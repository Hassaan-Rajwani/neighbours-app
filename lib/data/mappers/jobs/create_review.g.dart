// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReview _$CreateReviewFromJson(Map<String, dynamic> json) => CreateReview(
      detail: json['detail'] as int,
      rate: json['rate'] as int,
    );

Map<String, dynamic> _$CreateReviewToJson(CreateReview instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'detail': instance.detail,
    };
