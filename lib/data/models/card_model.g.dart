// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'] as String,
      isDefault: json['isDefault'] as bool,
      card: CardInfo.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'isDefault': instance.isDefault,
      'id': instance.id,
      'card': instance.card,
    };

CardInfo _$CardInfoFromJson(Map<String, dynamic> json) => CardInfo(
      brand: json['brand'] as String,
      country: json['country'] as String,
      last4: json['last4'] as String,
    );

Map<String, dynamic> _$CardInfoToJson(CardInfo instance) => <String, dynamic>{
      'brand': instance.brand,
      'country': instance.country,
      'last4': instance.last4,
    };
