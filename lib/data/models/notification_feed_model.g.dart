// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationFeedModel _$NotificationFeedModelFromJson(
        Map<String, dynamic> json) =>
    NotificationFeedModel(
      unReadCount: json['unreadCount'] as int,
      notificationList: (json['notifications'] as List<dynamic>)
          .map((e) =>
              NotificationFeedBodyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationFeedModelToJson(
        NotificationFeedModel instance) =>
    <String, dynamic>{
      'unreadCount': instance.unReadCount,
      'notifications': instance.notificationList,
    };

NotificationFeedBodyModel _$NotificationFeedBodyModelFromJson(
        Map<String, dynamic> json) =>
    NotificationFeedBodyModel(
      id: json['_id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isRead: json['isRead'] as bool,
      route:
          NotificationRouteModel.fromJson(json['data'] as Map<String, dynamic>),
      sender: NotificationSenderModel.fromJson(
          json['sender'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$NotificationFeedBodyModelToJson(
        NotificationFeedBodyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'isRead': instance.isRead,
      'data': instance.route,
      'sender': instance.sender,
    };

NotificationRouteModel _$NotificationRouteModelFromJson(
        Map<String, dynamic> json) =>
    NotificationRouteModel(
      url: json['url'] as String,
      jobId: json['jobId'] as String?,
    );

Map<String, dynamic> _$NotificationRouteModelToJson(
        NotificationRouteModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'jobId': instance.jobId,
    };

NotificationSenderModel _$NotificationSenderModelFromJson(
        Map<String, dynamic> json) =>
    NotificationSenderModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$NotificationSenderModelToJson(
        NotificationSenderModel instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
