part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

class GetMessagesListInProgress extends MessagesState {}

class NoChatMessagesInProgress extends MessagesState {}

class NoChatMessagesSuccessfull extends MessagesState {}

class GetChatMessagesSuccessfully extends MessagesState {
  const GetChatMessagesSuccessfully({
    required this.chatMessagesList,
  });

  final List<ChatMessagesModel> chatMessagesList;
}
