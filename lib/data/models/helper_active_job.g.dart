// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_active_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelperActiveJobModel _$HelperActiveJobModelFromJson(
        Map<String, dynamic> json) =>
    HelperActiveJobModel(
      id: json['_id'] as String,
      amount: json['amount'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      numberOfPackage: json['number_of_package'] as int,
      size: (json['size'] as List<dynamic>).map((e) => e as String).toList(),
      budget: json['budget'] as int,
      pickupType: (json['pickup_type'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      neighbourId:
          NeighborDataModel.fromJson(json['neighbor'] as Map<String, dynamic>),
      status: json['status'] as String,
      bids: (json['bids'] as List<dynamic>).map((e) => e as String).toList(),
      packages:
          (json['packets'] as List<dynamic>).map((e) => e as String).toList(),
      helperDistance: (json['helper_distance'] as num).toDouble(),
      distanceUnit: json['distance_unit'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$HelperActiveJobModelToJson(
        HelperActiveJobModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'number_of_package': instance.numberOfPackage,
      'size': instance.size,
      'budget': instance.budget,
      'pickup_type': instance.pickupType,
      'description': instance.description,
      'neighbor': instance.neighbourId,
      'status': instance.status,
      'bids': instance.bids,
      'packets': instance.packages,
      'helper_distance': instance.helperDistance,
      'distance_unit': instance.distanceUnit,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'amount': instance.amount,
      'address': instance.address,
    };

NeighborDataModel _$NeighborDataModelFromJson(Map<String, dynamic> json) =>
    NeighborDataModel(
      helper:
          HelperRatingModel.fromJson(json['helper'] as Map<String, dynamic>),
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      active: json['active'] as bool,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$NeighborDataModelToJson(NeighborDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'active': instance.active,
      'image_url': instance.imageUrl,
      'helper': instance.helper,
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
