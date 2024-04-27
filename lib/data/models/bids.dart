import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';

part 'bids.g.dart';

@JsonSerializable()
class BidsModel {
  BidsModel({
    required this.id,
    required this.jobId,
    required this.status,
    required this.amount,
    required this.distance,
    required this.neighbourId,
    required this.distanceUnit,
    required this.helperInfo,
    this.description = '',
  });

  factory BidsModel.fromJson(Map<String, dynamic> json) =>
      _$BidsModelFromJson(json);
  Map<String, dynamic> toJson() => _$BidsModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'neighbour_id')
  final String neighbourId;

  @JsonKey(name: 'job_id')
  final String jobId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'distance')
  final double distance;

  @JsonKey(name: 'distance_unit')
  final String distanceUnit;

  @JsonKey(name: 'helper_id')
  final HelperDataModel helperInfo;
}

@JsonSerializable()
class HelperDataModel {
  const HelperDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    required this.helperRating,
    this.address,
    this.imageUrl,
  });

  factory HelperDataModel.fromJson(Map<String, dynamic> json) =>
      _$HelperDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperDataModelToJson(this);

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

  @JsonKey(name: 'address')
  final AddressModel? address;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'helper')
  final HelperRatingModel helperRating;
}

@JsonSerializable()
class HelperRatingModel {
  const HelperRatingModel({
    required this.rating,
    required this.jobDone,
  });

  factory HelperRatingModel.fromJson(Map<String, dynamic> json) =>
      _$HelperRatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperRatingModelToJson(this);

  @JsonKey(name: 'rating')
  final double rating;

  @JsonKey(name: 'job_done')
  final int jobDone;
}
