// ignore_for_file: avoid_dynamic_calls
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/models/chat_messages_model.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/widgets/chat_appbar.dart';
import 'package:neighbour_app/pages/Chat/widgets/chat_input.dart';
import 'package:neighbour_app/pages/Chat/widgets/message_box.dart';
import 'package:neighbour_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:neighbour_app/presentation/bloc/messages/messages_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/envs.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.data,
    super.key,
  });

  final Map<String, dynamic> data;
  static const routeName = '/chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isMessageEmpty = true;
  TextEditingController msgController = TextEditingController();
  List<dynamic> messages = [];
  List<dynamic> msg = [];
  ScrollController scollController = ScrollController();

  late IOWebSocketChannel _channel;

  @override
  void initState() {
    _channel = IOWebSocketChannel.connect(
      Uri.parse(
        '''${dotenv.env[EnvKeys.websocketURL]}?senderUserId=${widget.data['userId']}''',
      ),
      headers: <String, String>{
        'Authorization': widget.data['userId'].toString(),
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    startStream();
    getMessages();
    super.didChangeDependencies();
  }

  Future<void> getList() async {
    sl<ChatBloc>().add(GetChatRoomListEvent());
  }

  Future<void> startStream() async {
    _channel.stream.listen((event) {
      final decodedData = jsonDecode('$event');
      setState(() {
        final message = ChatMessagesModel(
          roomKey: decodedData['roomKey'].toString(),
          senderId: decodedData['sender'].toString(),
          text: decodedData['text'].toString(),
          id: '0',
        );

        final obj = message;
        messages.insert(0, obj);
      });
      Timer(
        const Duration(milliseconds: 300),
        () => scollController.animateTo(
          0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        ),
      );
    });
  }

  Future<void> getMessages() async {
    if (widget.data['roomId'] != null) {
      sl<MessagesBloc>().add(
        GetChatMessagesEvent(
          roomId: widget.data['roomId'].toString(),
        ),
      );
    } else {
      sl<MessagesBloc>().add(NoChatMessagesEvent());
      Future.delayed(const Duration(seconds: 2), () {
        messages.clear();
        msg.clear();
      });
    }
  }

  void sendMessage(String message) {
    final msg = message.trim();
    if (msg.isEmpty) {
      return;
    }

    final recipentId = widget.data['helperId'] ?? '655487d9bdbab9ae2cb64940';
    final userID = widget.data['userId'];
    final channelMessage = {
      'action': 'sendmessage',
      'text': msg,
      'senderUserId': '$userID',
      'recipientUserId': '$recipentId',
    };

    final chatMessage = ChatMessagesModel(
      roomKey: '',
      senderId: userID.toString(),
      text: message.trim(),
      id: '',
    );
    setState(() {
      _channel.sink.add(jsonEncode(channelMessage));
      msgController.text = '';
      messages.insert(0, chatMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        if (state is GetMessagesListInProgress ||
            state is NoChatMessagesInProgress) {
          return const CircularLoader();
        }
        if (state is GetChatMessagesSuccessfully) {
          messages = state.chatMessagesList;
          msg = messages;
        } else {
          msg = messages;
        }
        return GestureDetector(
          onTap: () {
            keyboardDismissle(context: context);
          },
          child: WillPopScope(
            onWillPop: () async {
              await getList();
              return true;
            },
            child: Scaffold(
              backgroundColor: scafColor,
              body: SafeArea(
                child: Column(
                  children: [
                    ChatAppbar(
                      firstName: widget.data['firstName'].toString(),
                      lastName: widget.data['lastName'].toString(),
                      name: widget.data['name'].toString(),
                      image: widget.data['image'].toString(),
                      onTap: () {
                        getList();
                        context.pop();
                      },
                    ),
                    Expanded(
                      child: ColoredBox(
                        color: scafColor,
                        child: ListView.builder(
                          itemCount: msg.length,
                          reverse: true,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return msg[index].senderId.toString() ==
                                    widget.data['userId']
                                ? SenderWidget(
                                    senderMessage: msg[index].text.toString(),
                                  )
                                : RecieverWidget(
                                    recieverMessage: msg[index].text.toString(),
                                  );
                          },
                        ),
                      ),
                    ),
                    ChatInput(
                      msg: msgController,
                      isMessageEmpty: isMessageEmpty,
                      onPress: () {
                        sendMessage(msgController.value.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
