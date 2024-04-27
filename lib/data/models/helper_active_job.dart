import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';

part 'helper_active_job.g.dart';

@JsonSerializable()
class HelperActiveJobModel {
  const HelperActiveJobModel({
    required this.id,
    required this.amount,
    required this.title,
    required this.type,
    required this.numberOfPackage,
    required this.size,
    required this.budget,
    required this.pickupType,
    required this.description,
    required this.neighbourId,
    required this.status,
    required this.bids,
    required this.packages,
    required this.helperDistance,
    required this.distanceUnit,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HelperActiveJobModel.fromJson(Map<String, dynamic> json) =>
      _$HelperActiveJobModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperActiveJobModelToJson(this);

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

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'neighbor')
  final NeighborDataModel neighbourId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'bids')
  final List<String> bids;

  @JsonKey(name: 'packets')
  final List<String> packages;

  @JsonKey(name: 'helper_distance')
  final double helperDistance;

  @JsonKey(name: 'distance_unit')
  final String distanceUnit;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'address')
  final AddressModel address;
}

@JsonSerializable()
class NeighborDataModel {
  const NeighborDataModel({
    required this.helper,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    this.imageUrl,
  });

  factory NeighborDataModel.fromJson(Map<String, dynamic> json) =>
      _$NeighborDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NeighborDataModelToJson(this);

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

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'helper')
  final HelperRatingModel helper;
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
