import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class FavoriteModel {
  const FavoriteModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.userId,
    this.imageUrl,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'rating')
  final double rating;
}
