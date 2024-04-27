// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpers_pending_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpersPendingJobModel _$HelpersPendingJobModelFromJson(
        Map<String, dynamic> json) =>
    HelpersPendingJobModel(
      distanceUnit: json['distance_unit'] as String,
      id: json['_id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      numberOfPackage: json['number_of_package'] as int,
      size: (json['size'] as List<dynamic>).map((e) => e as String).toList(),
      budget: json['budget'] as int,
      pickupType: (json['pickup_type'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      neighbourId: NeighborDataModel.fromJson(
          json['neighbour_id'] as Map<String, dynamic>),
      status: json['status'] as String,
      bids: (json['bids'] as List<dynamic>)
          .map((e) => BidsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages:
          (json['packets'] as List<dynamic>).map((e) => e as String).toList(),
      helperDistance: (json['distance'] as num).toDouble(),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      isRejected: json['isRejected'] as bool,
    );

Map<String, dynamic> _$HelpersPendingJobModelToJson(
        HelpersPendingJobModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'number_of_package': instance.numberOfPackage,
      'size': instance.size,
      'budget': instance.budget,
      'pickup_type': instance.pickupType,
      'description': instance.description,
      'neighbour_id': instance.neighbourId,
      'status': instance.status,
      'isRejected': instance.isRejected,
      'bids': instance.bids,
      'packets': instance.packages,
      'distance': instance.helperDistance,
      'distance_unit': instance.distanceUnit,
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
      'image_url': instance.imageUrl,
      'active': instance.active,
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

BidsDataModel _$BidsDataModelFromJson(Map<String, dynamic> json) =>
    BidsDataModel(
      helperId: json['helper_id'] as String,
      id: json['_id'] as String,
      neighborId: json['neighbour_id'] as String,
      status: json['status'] as String,
      amount: json['amount'] as int,
      jobId: json['job_id'] as String,
    );

Map<String, dynamic> _$BidsDataModelToJson(BidsDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'helper_id': instance.helperId,
      'neighbour_id': instance.neighborId,
      'job_id': instance.jobId,
      'status': instance.status,
      'amount': instance.amount,
    };
