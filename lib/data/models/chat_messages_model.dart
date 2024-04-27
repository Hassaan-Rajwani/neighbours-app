import 'package:json_annotation/json_annotation.dart';

part 'chat_messages_model.g.dart';

@JsonSerializable()
class ChatMessagesModel {
  ChatMessagesModel({
    required this.roomKey,
    required this.senderId,
    required this.text,
    required this.id,
  });

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessagesModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'roomKey')
  final String roomKey;

  @JsonKey(name: 'text')
  final String text;

  @JsonKey(name: 'sender')
  final String senderId;
}
