import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/chat_messages_model.dart';
import 'package:neighbour_app/domain/repository/chat_repository.dart';

class GetMessagesParms {
  GetMessagesParms({
    required this.token,
    required this.roomId,
  });

  String token;
  String roomId;
}

class GetChatMessagesUseCase
    implements UseCase<DataState<List<ChatMessagesModel>>, GetMessagesParms> {
  GetChatMessagesUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  @override
  Future<DataState<List<ChatMessagesModel>>> call(GetMessagesParms parms) {
    return _chatRepository.getChatMessages(
      parms.token,
      parms.roomId,
    );
  }
}
