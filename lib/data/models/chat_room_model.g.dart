// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      id: json['_id'] as String,
      room: json['roomKey'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => ChatRoomUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['lastMessageInChatroom'] as String,
      unReadCount: json['unreadMessageCount'],
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'roomKey': instance.room,
      'users': instance.users,
      'unreadMessageCount': instance.unReadCount,
      'lastMessageInChatroom': instance.lastMessage,
    };

ChatRoomUserModel _$ChatRoomUserModelFromJson(Map<String, dynamic> json) =>
    ChatRoomUserModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      image: json['image_url'] as String?,
    );

Map<String, dynamic> _$ChatRoomUserModelToJson(ChatRoomUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image_url': instance.image,
    };
