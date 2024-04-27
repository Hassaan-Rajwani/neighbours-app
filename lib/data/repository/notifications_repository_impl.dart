import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/notification_feed_model.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationRepository {
  NotificationsRepositoryImpl(this._neighborsApiService);

  final NeighborApiService _neighborsApiService;

  @override
  Future<DataState<NotificationFeedModel>> getNotificationList({
    required String token,
    required bool isNeighbr,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.getNotificationList(
        authToken: 'Bearer $token',
        isNeighbr: isNeighbr,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(NotificationFeedModel.fromJson(response.data!));
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
  Future<DataState<String?>> updateNotification({
    required String token,
    required bool isNeighbr,
    required String notificationId,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.markAsReadNotification(
        authToken: 'Bearer $token',
        isNeighbr: isNeighbr,
        notificationId: notificationId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
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
  Future<DataState<String?>> deleteNotification({
    required String token,
    required bool isNeighbr,
    required String notificationId,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.deleteNotification(
        authToken: 'Bearer $token',
        isNeighbr: isNeighbr,
        notificationId: notificationId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
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
