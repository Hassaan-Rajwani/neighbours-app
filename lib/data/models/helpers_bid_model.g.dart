// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpers_bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpersBidModel _$HelpersBidModelFromJson(Map<String, dynamic> json) =>
    HelpersBidModel(
      helperId: json['helper_id'] as String,
      neighbourId: json['neighbour_id'] as String,
      jobId: json['job_id'] as String,
      status: json['status'] as String,
      amount: json['amount'] as int,
      distance: json['distance'] as String,
      distanceUnit: json['distance_unit'] as String,
      Id: json['_id'] as String,
    );

Map<String, dynamic> _$HelpersBidModelToJson(HelpersBidModel instance) =>
    <String, dynamic>{
      'helper_id': instance.helperId,
      'neighbour_id': instance.neighbourId,
      'job_id': instance.jobId,
      'status': instance.status,
      'amount': instance.amount,
      'distance': instance.distance,
      'distance_unit': instance.distanceUnit,
      '_id': instance.Id,
    };
