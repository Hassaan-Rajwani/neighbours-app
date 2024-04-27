// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model_with_helper_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModelWithHelperInfo _$JobModelWithHelperInfoFromJson(
        Map<String, dynamic> json) =>
    JobModelWithHelperInfo(
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
      helperId: json['helper'] == null
          ? null
          : HelperIdModel.fromJson(json['helper'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobModelWithHelperInfoToJson(
        JobModelWithHelperInfo instance) =>
    <String, dynamic>{
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
      'helper': instance.helperId,
    };

HelperIdModel _$HelperIdModelFromJson(Map<String, dynamic> json) =>
    HelperIdModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      active: json['active'] as bool,
      jobs: json['jobs'] as List<dynamic>,
      bids: json['bids'] as List<dynamic>,
      cognitoId: json['cognito_id'] as String,
      stripeConnectId: json['stripe_connect_id'] as String,
      StripeCustomerId: json['stripe_customer_id'] as String,
      helper: HelperModel.fromJson(json['helper'] as Map<String, dynamic>),
      neighbr: HelperModel.fromJson(json['neighbr'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$HelperIdModelToJson(HelperIdModel instance) =>
    <String, dynamic>{
      'helper': instance.helper,
      'neighbr': instance.neighbr,
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'active': instance.active,
      'jobs': instance.jobs,
      'bids': instance.bids,
      'cognito_id': instance.cognitoId,
      'stripe_connect_id': instance.stripeConnectId,
      'stripe_customer_id': instance.StripeCustomerId,
      'image_url': instance.imageUrl,
    };

HelperModel _$HelperModelFromJson(Map<String, dynamic> json) => HelperModel(
      jobDone: json['job_done'] as int,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$HelperModelToJson(HelperModel instance) =>
    <String, dynamic>{
      'job_done': instance.jobDone,
      'rating': instance.rating,
    };
