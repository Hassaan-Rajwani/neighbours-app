part of 'notification_feed_bloc.dart';

sealed class NotificationFeedEvent extends Equatable {
  const NotificationFeedEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationFeedEvent {
  const GetNotificationEvent({
    required this.isNeighbr,
  });

  final bool isNeighbr;
}

class MarkAsReadNotification extends NotificationFeedEvent {
  const MarkAsReadNotification({
    required this.isNeighbr,
    required this.notificationId,
  });

  final bool isNeighbr;
  final String notificationId;
}

class DeleteNotification extends NotificationFeedEvent {
  const DeleteNotification({
    required this.isNeighbr,
    required this.notificationId,
  });

  final bool isNeighbr;
  final String notificationId;
}
