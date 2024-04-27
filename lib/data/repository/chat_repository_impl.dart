import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/models/chat_messages_model.dart';
import 'package:neighbour_app/data/models/chat_room_model.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._neighborsApiService);

  final NeighborApiService _neighborsApiService;

  @override
  Future<DataState<List<ChatRoomModel>>> getChatRooms(String token) async {
    try {
      final httpResponse = await _neighborsApiService.getChatRooms(
        authToken: 'Bearer $token',
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final chatRooms = <ChatRoomModel>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            chatRooms.add(ChatRoomModel.fromJson(list[i]));
          }
          return DataSuccess(chatRooms);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ChatMessagesModel>>> getChatMessages(
    String token,
    String roomId,
  ) async {
    try {
      final httpResponse = await _neighborsApiService.getChatMessages(
        authToken: 'Bearer $token',
        chatRoomId: roomId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final chatRooms = <ChatMessagesModel>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            chatRooms.add(ChatMessagesModel.fromJson(list[i]));
          }
          return DataSuccess(chatRooms);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
