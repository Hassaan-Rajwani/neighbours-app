import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';
part 'helpers_pending_job.g.dart';

@JsonSerializable()
class HelpersPendingJobModel {
  HelpersPendingJobModel({
    required this.distanceUnit,
    required this.id,
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
    required this.address,
    required this.isRejected,
  });

  factory HelpersPendingJobModel.fromJson(Map<String, dynamic> json) =>
      _$HelpersPendingJobModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelpersPendingJobModelToJson(this);

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

  @JsonKey(name: 'neighbour_id')
  final NeighborDataModel neighbourId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'isRejected')
  bool isRejected;

  @JsonKey(name: 'bids')
  final List<BidsDataModel> bids;

  @JsonKey(name: 'packets')
  final List<String> packages;

  @JsonKey(name: 'distance')
  final double helperDistance;

  @JsonKey(name: 'distance_unit')
  final String distanceUnit;

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

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'active')
  final bool active;

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

@JsonSerializable()
class BidsDataModel {
  const BidsDataModel({
    required this.helperId,
    required this.id,
    required this.neighborId,
    required this.status,
    required this.amount,
    required this.jobId,
  });

  factory BidsDataModel.fromJson(Map<String, dynamic> json) =>
      _$BidsDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$BidsDataModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'helper_id')
  final String helperId;

  @JsonKey(name: 'neighbour_id')
  final String neighborId;

  @JsonKey(name: 'job_id')
  final String jobId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'amount')
  final int amount;
}
