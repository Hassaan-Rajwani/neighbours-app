part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class GetChatRoomsSuccessfully extends ChatState {
  const GetChatRoomsSuccessfully({
    required this.chatRoomList,
  });

  final List<ChatRoomModel> chatRoomList;
}
