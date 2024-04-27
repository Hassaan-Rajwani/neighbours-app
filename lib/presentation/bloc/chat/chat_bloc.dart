import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/chat_room_model.dart';
import 'package:neighbour_app/domain/usecases/chat/get_chat_room_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    this._getChatRoomUseCase,
  ) : super(ChatInitial()) {
    on<GetChatRoomListEvent>(_getChatRoomList);
  }

  final GetChatRoomUseCase _getChatRoomUseCase;

  Future<void> _getChatRoomList(
    GetChatRoomListEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatInitial());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getChatRoomUseCase(token);
      if (dataState.data != null) {
        emit(GetChatRoomsSuccessfully(chatRoomList: dataState.data!));
      }
    }
  }
}
