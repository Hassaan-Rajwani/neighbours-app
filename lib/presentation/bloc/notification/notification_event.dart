// ignore_for_file: must_be_immutable
part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class PostFcmTokenEvent extends NotificationEvent {
  PostFcmTokenEvent({
    required this.body,
  });

  Map<String, dynamic> body;
}
