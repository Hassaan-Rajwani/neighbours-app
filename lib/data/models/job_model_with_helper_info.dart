// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';

part 'job_model_with_helper_info.g.dart';

@JsonSerializable()
class JobModelWithHelperInfo {
  JobModelWithHelperInfo({
    required this.id,
    required this.title,
    required this.type,
    required this.numberOfPackage,
    required this.size,
    required this.budget,
    required this.pickupType,
    required this.address,
    required this.description,
    required this.neighborId,
    required this.status,
    required this.bids,
    required this.packages,
    this.helperId,
  });

  factory JobModelWithHelperInfo.fromJson(Map<String, dynamic> json) =>
      _$JobModelWithHelperInfoFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelWithHelperInfoToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'number_of_package')
  final int numberOfPackage;

  @JsonKey(name: 'size')
  final List<String> size;

  @JsonKey(name: 'budget')
  final int budget;

  @JsonKey(name: 'pickup_type')
  final List<String> pickupType;

  @JsonKey(name: 'address')
  final AddressModel address;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'neighbour_id')
  final String neighborId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'bids')
  final List<dynamic> bids;

  @JsonKey(name: 'packets')
  final List<dynamic> packages;

  @JsonKey(name: 'helper')
  HelperIdModel? helperId;
}

@JsonSerializable()
class HelperIdModel {
  const HelperIdModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    required this.jobs,
    required this.bids,
    required this.cognitoId,
    required this.stripeConnectId,
    required this.StripeCustomerId,
    required this.helper,
    required this.neighbr,
    this.imageUrl,
  });
  factory HelperIdModel.fromJson(Map<String, dynamic> json) =>
      _$HelperIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperIdModelToJson(this);

  @JsonKey(name: 'helper')
  final HelperModel helper;

  @JsonKey(name: 'neighbr')
  final HelperModel neighbr;

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'active')
  final bool active;

  @JsonKey(name: 'jobs')
  final List<dynamic> jobs;

  @JsonKey(name: 'bids')
  final List<dynamic> bids;

  @JsonKey(name: 'cognito_id')
  final String cognitoId;

  @JsonKey(name: 'stripe_connect_id')
  final String stripeConnectId;

  @JsonKey(name: 'stripe_customer_id')
  final String StripeCustomerId;

  @JsonKey(name: 'image_url')
  final String? imageUrl;
}

@JsonSerializable()
class HelperModel {
  const HelperModel({
    required this.jobDone,
    required this.rating,
  });
  factory HelperModel.fromJson(Map<String, dynamic> json) =>
      _$HelperModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperModelToJson(this);

  @JsonKey(name: 'job_done')
  final int jobDone;

  @JsonKey(name: 'rating')
  final double rating;
}
