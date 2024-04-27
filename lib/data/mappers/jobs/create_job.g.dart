// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateJob _$CreateJobFromJson(Map<String, dynamic> json) => CreateJob(
      json['title'] as String,
      json['type'] as String,
      json['number_of_package'] as int,
      json['budget'] as int,
      (json['pickup_type'] as List<dynamic>).map((e) => e as String).toList(),
      json['description'] as String,
      json['address'] as String,
      size: (json['size'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateJobToJson(CreateJob instance) => <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'number_of_package': instance.numberOfPackages,
      'size': instance.size,
      'budget': instance.budget,
      'pickup_type': instance.pickupType,
      'description': instance.description,
      'address': instance.address,
    };
