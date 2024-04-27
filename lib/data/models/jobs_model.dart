import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';

part 'jobs_model.g.dart';

@JsonSerializable()
class JobModel {
  JobModel({
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
    this.raisedBy,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);

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

  @JsonKey(name: 'helper_id')
  HelperIdModel? helperId;

  @JsonKey(name: 'raised_by')
  String? raisedBy;
}
