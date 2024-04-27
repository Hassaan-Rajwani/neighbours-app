// ignore_for_file: unnecessary_type_check, prefer_if_null_operators, unnecessary_null_comparison, lines_longer_than_80_chars
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/models/chat_room_model.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/Chat/widgets/chat_contact.dart';
import 'package:neighbour_app/pages/Chat/widgets/image_builder.dart';
import 'package:neighbour_app/pages/Home/widgets/main_saerch_bar.dart';
import 'package:neighbour_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  static String routeName = '/chats';

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<ChatRoomModel> _filterContactList = [];

  @override
  void initState() {
    onRefresh();
    getListFilter();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getListFilter();
    super.didChangeDependencies();
  }

  void getListFilter() {
    final state = context.read<ChatBloc>().state;
    if (state is GetChatRoomsSuccessfully) {
      setState(() {
        _filterContactList = state.chatRoomList;
      });
    }
  }

  Future<void> onRefresh() async {
    sl<ChatBloc>().add(GetChatRoomListEvent());
  }

  @override
  Widget build(BuildContext context) {
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        didChangeDependencies();
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatInitial) {
            return const CircularLoader();
          }
          if (state is GetChatRoomsSuccessfully) {
            void filteredList({required String text}) {
              _filterContactList = state.chatRoomList
                  .where(
                    (data) => data.users.any(
                      (person) => person.firstName.toLowerCase().contains(
                            text.toLowerCase(),
                          ),
                    ),
                  )
                  .toList();
            }

            return Scaffold(
              backgroundColor: scafColor,
              body: RefreshIndicator(
                onRefresh: onRefresh,
                child: SafeArea(
                  maintainBottomViewPadding: true,
                  child: Column(
                    children: [
                      const Gap(
                        gap: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeHelper.moderateScale(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (profileState is ProfileInitial)
                              Row(
                                children: [
                                  ImageBuilder(
                                    firstName: profileState.firstName,
                                    lastName: profileState.lastName,
                                  ),
                                  const Gap(
                                    gap: 15,
                                    axis: 'x',
                                  ),
                                  Text(
                                    'Hi, ${profileState.firstName.pascalCase}',
                                    style: TextStyle(
                                      fontFamily: ralewayBold,
                                      fontSize: SizeHelper.moderateScale(16),
                                      color: shark,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const Gap(
                        gap: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeHelper.moderateScale(
                            20,
                          ),
                        ),
                        child: SizedBox(
                          height: SizeHelper.moderateScale(60),
                          child: MainSearchbar(
                            hintText: 'Search for users',
                            onChangeText: (text) {
                              setState(() {
                                filteredList(text: text);
                              });
                            },
                            borderRadius: SizeHelper.moderateScale(64),
                            filledColor: Colors.white,
                            iconColor: baliHai,
                          ),
                        ),
                      ),
                      const Gap(
                        gap: 20,
                      ),
                      if (_filterContactList.isEmpty)
                        const Text('No Rooms Available')
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: _filterContactList.length,
                            itemBuilder: (context, index) {
                              final currentItem = _filterContactList[index];
                              final myId = profileState is ProfileInitial
                                  ? profileState.id
                                  : 0;
                              final otherUsers = currentItem.users
                                  .where((user) => user.id != myId)
                                  .toList();
                              final user = otherUsers[0];
                              final messageCount =
                                  currentItem.unReadCount != null
                                      ? extractNumber(
                                          currentItem.unReadCount,
                                        )
                                      : 0;
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: SizeHelper.moderateScale(
                                    _filterContactList.length - 1 == index
                                        ? 80
                                        : 0,
                                  ),
                                ),
                                child: ChatContact(
                                  name: user.firstName,
                                  image: '${user.image}',
                                  message: currentItem.lastMessage,
                                  unreadMessages: '$messageCount',
                                  time: '',
                                  onTap: () {
                                    final myId = profileState is ProfileInitial
                                        ? profileState.id
                                        : '';
                                    final query = Uri(
                                      queryParameters: {
                                        'firstName': user.firstName,
                                        'lastName': user.lastName,
                                        'name': user.firstName,
                                        'userId': myId,
                                        'roomId': currentItem.id,
                                        'helperId': user.id,
                                        'image': '${user.image}',
                                      },
                                    ).query;
                                    context.push(
                                      '${ChatPage.routeName}?$query',
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      const Gap(gap: 60),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
