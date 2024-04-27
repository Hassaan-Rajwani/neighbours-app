import 'package:json_annotation/json_annotation.dart';

part 'add_favorite.g.dart';

@JsonSerializable()
class AddFavorite {
  AddFavorite({required this.helperId});

  factory AddFavorite.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteFromJson(json);

  @JsonKey(name: 'helper_id')
  final String helperId;

  Map<String, dynamic> toJson() => _$AddFavoriteToJson(this);
}
