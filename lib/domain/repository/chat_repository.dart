// ignore_for_file: one_member_abstracts
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/chat_messages_model.dart';
import 'package:neighbour_app/data/models/chat_room_model.dart';

abstract class ChatRepository {
  Future<DataState<List<ChatRoomModel>>> getChatRooms(String token);
  Future<DataState<List<ChatMessagesModel>>> getChatMessages(
    String token,
    String roomId,
  );
}
