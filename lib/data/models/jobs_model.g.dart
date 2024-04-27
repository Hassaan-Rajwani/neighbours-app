// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      numberOfPackage: json['number_of_package'] as int,
      size: (json['size'] as List<dynamic>).map((e) => e as String).toList(),
      budget: json['budget'] as int,
      pickupType: (json['pickup_type'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      description: json['description'] as String,
      neighborId: json['neighbour_id'] as String,
      status: json['status'] as String,
      bids: json['bids'] as List<dynamic>,
      packages: json['packets'] as List<dynamic>,
      helperId: json['helper_id'] == null
          ? null
          : HelperIdModel.fromJson(json['helper_id'] as Map<String, dynamic>),
      raisedBy: json['raised_by'] as String?,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'number_of_package': instance.numberOfPackage,
      'size': instance.size,
      'budget': instance.budget,
      'pickup_type': instance.pickupType,
      'address': instance.address,
      'description': instance.description,
      'neighbour_id': instance.neighborId,
      'status': instance.status,
      'bids': instance.bids,
      'packets': instance.packages,
      'helper_id': instance.helperId,
      'raised_by': instance.raisedBy,
    };
