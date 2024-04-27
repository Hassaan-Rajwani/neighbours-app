import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  CardModel({
    required this.id,
    required this.isDefault,
    required this.card,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  @JsonKey(name: 'isDefault')
  bool isDefault;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'card')
  final CardInfo card;
}

@JsonSerializable()
class CardInfo {
  CardInfo({
    required this.brand,
    required this.country,
    required this.last4,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) =>
      _$CardInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CardInfoToJson(this);

  @JsonKey(name: 'brand')
  final String brand;

  @JsonKey(name: 'country')
  final String country;

  @JsonKey(name: 'last4')
  final String last4;
}
