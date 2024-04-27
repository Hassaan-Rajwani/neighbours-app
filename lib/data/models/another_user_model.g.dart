// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'another_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnotherUserModel _$AnotherUserModelFromJson(Map<String, dynamic> json) =>
    AnotherUserModel(
      userId: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      helper:
          HelperRatingModel.fromJson(json['helper'] as Map<String, dynamic>),
      neighbr:
          HelperRatingModel.fromJson(json['neighbr'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool,
      imageUrl: json['image_url'] as String?,
      favorite: json['favorite'] == null
          ? null
          : FavoriteDataModel.fromJson(
              json['favorite'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnotherUserModelToJson(AnotherUserModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image_url': instance.imageUrl,
      'helper': instance.helper,
      'neighbr': instance.neighbr,
      'isFavorite': instance.isFavorite,
      'favorite': instance.favorite,
    };
