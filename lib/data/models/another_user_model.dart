import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/favorite_data.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';

part 'another_user_model.g.dart';

@JsonSerializable()
class AnotherUserModel {
  AnotherUserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.helper,
    required this.neighbr,
    required this.isFavorite,
    this.imageUrl,
    this.favorite,
  });

  factory AnotherUserModel.fromJson(Map<String, dynamic> json) =>
      _$AnotherUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnotherUserModelToJson(this);

  @JsonKey(name: '_id')
  final String userId;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'helper')
  final HelperRatingModel helper;

  @JsonKey(name: 'neighbr')
  final HelperRatingModel neighbr;

  @JsonKey(name: 'isFavorite')
  bool isFavorite;

  @JsonKey(name: 'favorite')
  final FavoriteDataModel? favorite;
}
