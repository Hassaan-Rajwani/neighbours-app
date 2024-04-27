// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidsModel _$BidsModelFromJson(Map<String, dynamic> json) => BidsModel(
      id: json['_id'] as String,
      jobId: json['job_id'] as String,
      status: json['status'] as String,
      amount: json['amount'] as int,
      distance: (json['distance'] as num).toDouble(),
      neighbourId: json['neighbour_id'] as String,
      distanceUnit: json['distance_unit'] as String,
      helperInfo:
          HelperDataModel.fromJson(json['helper_id'] as Map<String, dynamic>),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$BidsModelToJson(BidsModel instance) => <String, dynamic>{
      '_id': instance.id,
      'neighbour_id': instance.neighbourId,
      'job_id': instance.jobId,
      'status': instance.status,
      'amount': instance.amount,
      'description': instance.description,
      'distance': instance.distance,
      'distance_unit': instance.distanceUnit,
      'helper_id': instance.helperInfo,
    };

HelperDataModel _$HelperDataModelFromJson(Map<String, dynamic> json) =>
    HelperDataModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      active: json['active'] as bool,
      helperRating:
          HelperRatingModel.fromJson(json['helper'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$HelperDataModelToJson(HelperDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'active': instance.active,
      'address': instance.address,
      'image_url': instance.imageUrl,
      'helper': instance.helperRating,
    };

HelperRatingModel _$HelperRatingModelFromJson(Map<String, dynamic> json) =>
    HelperRatingModel(
      rating: (json['rating'] as num).toDouble(),
      jobDone: json['job_done'] as int,
    );

Map<String, dynamic> _$HelperRatingModelToJson(HelperRatingModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'job_done': instance.jobDone,
    };
