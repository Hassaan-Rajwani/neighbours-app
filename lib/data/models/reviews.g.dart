// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) => ReviewsModel(
      id: json['_id'] as String,
      jobId: json['job'] as String,
      detail: json['detail'] as String,
      rate: (json['rate'] as num).toDouble(),
      neighbor: json['neighbour'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String,
      helper: json['helper'],
    );

Map<String, dynamic> _$ReviewsModelToJson(ReviewsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'job': instance.jobId,
      'detail': instance.detail,
      'rate': instance.rate,
      'neighbour': instance.neighbor,
      'helper': instance.helper,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
