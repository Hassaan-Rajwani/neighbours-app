import 'package:json_annotation/json_annotation.dart';

part 'favorite_data.g.dart';

@JsonSerializable()
class FavoriteDataModel {
  const FavoriteDataModel({
    required this.id,
  });

  factory FavoriteDataModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteDataModelToJson(this);

  @JsonKey(name: '_id')
  final String id;
}
