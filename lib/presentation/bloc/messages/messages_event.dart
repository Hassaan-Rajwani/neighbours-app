part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessagesEvent extends MessagesEvent {
  const GetChatMessagesEvent({
    required this.roomId,
  });

  final String roomId;
}

class NoChatMessagesEvent extends MessagesEvent {}
