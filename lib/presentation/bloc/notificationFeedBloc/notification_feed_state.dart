part of 'notification_feed_bloc.dart';

sealed class NotificationFeedState extends Equatable {
  const NotificationFeedState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationFeedState {}

class GetNotificationListInProgress extends NotificationFeedState {}

class GetNotificationListState extends NotificationFeedState {
  const GetNotificationListState({
    required this.list,
  });

  final NotificationFeedModel list;
}

class GetNotificationListError extends NotificationFeedState {
  const GetNotificationListError({required this.error});
  final String error;
}
