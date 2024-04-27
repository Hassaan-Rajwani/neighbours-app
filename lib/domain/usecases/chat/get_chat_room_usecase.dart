import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/chat_room_model.dart';
import 'package:neighbour_app/domain/repository/chat_repository.dart';

class GetChatRoomUseCase
    implements UseCase<DataState<List<ChatRoomModel>>, String> {
  GetChatRoomUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  @override
  Future<DataState<List<ChatRoomModel>>> call(String token) {
    return _chatRepository.getChatRooms(token);
  }
}
