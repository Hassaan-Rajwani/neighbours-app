import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/chat_messages_model.dart';
import 'package:neighbour_app/domain/usecases/chat/get_chat_messages_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc(this._getChatMessagesUseCase) : super(MessagesInitial()) {
    on<GetChatMessagesEvent>(_getChatMessages);
    on<NoChatMessagesEvent>(_noChatMessages);
  }

  final GetChatMessagesUseCase _getChatMessagesUseCase;

  Future<void> _getChatMessages(
    GetChatMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    emit(GetMessagesListInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetMessagesParms(
        token: token,
        roomId: event.roomId,
      );
      final dataState = await _getChatMessagesUseCase(params);
      if (dataState.data != null) {
        emit(GetChatMessagesSuccessfully(chatMessagesList: dataState.data!));
      }
    }
  }

  Future<void> _noChatMessages(
    NoChatMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    emit(NoChatMessagesInProgress());
    await Future.delayed(const Duration(seconds: 2), () {
      emit(NoChatMessagesSuccessfull());
    });
  }
}
