// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessagesModel _$ChatMessagesModelFromJson(Map<String, dynamic> json) =>
    ChatMessagesModel(
      roomKey: json['roomKey'] as String,
      senderId: json['sender'] as String,
      text: json['text'] as String,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ChatMessagesModelToJson(ChatMessagesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'roomKey': instance.roomKey,
      'text': instance.text,
      'sender': instance.senderId,
    };
