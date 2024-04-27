// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_neighbors_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeighborsPackageModel _$NeighborsPackageModelFromJson(
        Map<String, dynamic> json) =>
    NeighborsPackageModel(
      id: json['_id'] as String,
      helperId: json['helper_id'] as String,
      neighborsId: json['neighbour_id'] as String,
      jobId: json['job_id'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      tipStatus: json['confirm_tip'] as bool,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$NeighborsPackageModelToJson(
        NeighborsPackageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'helper_id': instance.helperId,
      'neighbour_id': instance.neighborsId,
      'job_id': instance.jobId,
      'image_url': instance.imageUrl,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'confirm_tip': instance.tipStatus,
    };
