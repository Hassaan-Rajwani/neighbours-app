import 'package:json_annotation/json_annotation.dart';

part 'notification_feed_model.g.dart';

@JsonSerializable()
class NotificationFeedModel {
  NotificationFeedModel({
    required this.unReadCount,
    required this.notificationList,
  });

  factory NotificationFeedModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationFeedModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationFeedModelToJson(this);

  @JsonKey(name: 'unreadCount')
  int unReadCount;

  @JsonKey(name: 'notifications')
  final List<NotificationFeedBodyModel> notificationList;
}

@JsonSerializable()
class NotificationFeedBodyModel {
  NotificationFeedBodyModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.description,
    required this.isRead,
    required this.route,
    required this.sender,
    required this.createdAt,
  });

  factory NotificationFeedBodyModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationFeedBodyModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationFeedBodyModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'senderId')
  final String senderId;

  @JsonKey(name: 'receiverId')
  final String receiverId;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'isRead')
  bool isRead;

  @JsonKey(name: 'data')
  final NotificationRouteModel route;

  @JsonKey(name: 'sender')
  final NotificationSenderModel sender;
}

@JsonSerializable()
class NotificationRouteModel {
  NotificationRouteModel({
    required this.url,
    this.jobId,
  });

  factory NotificationRouteModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationRouteModelToJson(this);

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'jobId')
  final String? jobId;
}

@JsonSerializable()
class NotificationSenderModel {
  NotificationSenderModel({
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  factory NotificationSenderModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSenderModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSenderModelToJson(this);

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;
}
