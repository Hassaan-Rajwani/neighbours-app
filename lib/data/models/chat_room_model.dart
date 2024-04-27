import 'package:json_annotation/json_annotation.dart';

part 'chat_room_model.g.dart';

@JsonSerializable()
class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.room,
    required this.users,
    required this.lastMessage,
    this.unReadCount,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'roomKey')
  final String room;

  @JsonKey(name: 'users')
  final List<ChatRoomUserModel> users;

  @JsonKey(name: 'unreadMessageCount')
  final dynamic unReadCount;

  @JsonKey(name: 'lastMessageInChatroom')
  final String lastMessage;
}

@JsonSerializable()
class ChatRoomUserModel {
  ChatRoomUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  factory ChatRoomUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomUserModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'image_url')
  String? image;
}
