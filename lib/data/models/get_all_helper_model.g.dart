// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_helper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllHelpersModel _$AllHelpersModelFromJson(Map<String, dynamic> json) =>
    AllHelpersModel(
      id: json['_id'] as String,
      fisrtName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      helperInfo:
          HelperRatingModel.fromJson(json['helper'] as Map<String, dynamic>),
      neighborInfo:
          HelperRatingModel.fromJson(json['neighbr'] as Map<String, dynamic>),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      distanceUnit: json['distance_unit'] as String?,
      milesCategory: json['category'] == null
          ? null
          : HelperCategoryMilesModel.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllHelpersModelToJson(AllHelpersModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.fisrtName,
      'last_name': instance.lastName,
      'email': instance.email,
      'distance_unit': instance.distanceUnit,
      'distance': instance.distance,
      'image_url': instance.imageUrl,
      'helper': instance.helperInfo,
      'neighbr': instance.neighborInfo,
      'address': instance.address,
      'category': instance.milesCategory,
    };

HelperCategoryMilesModel _$HelperCategoryMilesModelFromJson(
        Map<String, dynamic> json) =>
    HelperCategoryMilesModel(
      miles: (json['miles'] as num).toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$HelperCategoryMilesModelToJson(
        HelperCategoryMilesModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'miles': instance.miles,
    };
