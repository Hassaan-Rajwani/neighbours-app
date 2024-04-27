// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobHistoryModel _$JobHistoryModelFromJson(Map<String, dynamic> json) =>
    JobHistoryModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String,
      amount: json['amount'] as int? ?? 0,
    );

Map<String, dynamic> _$JobHistoryModelToJson(JobHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'description': instance.description,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
