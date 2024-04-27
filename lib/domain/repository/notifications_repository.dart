// ignore_for_file: one_member_abstracts
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/notification_feed_model.dart';

abstract class NotificationRepository {
  Future<DataState<NotificationFeedModel>> getNotificationList({
    required String token,
    required bool isNeighbr,
  });
  Future<DataState<String?>> updateNotification({
    required String token,
    required bool isNeighbr,
    required String notificationId,
  });
  Future<DataState<String?>> deleteNotification({
    required String token,
    required bool isNeighbr,
    required String notificationId,
  });
}
