// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'helpers_bid_model.g.dart';

@JsonSerializable()
class HelpersBidModel {
  HelpersBidModel({
    required this.helperId,
    required this.neighbourId,
    required this.jobId,
    required this.status,
    required this.amount,
    required this.distance,
    required this.distanceUnit,
    required this.Id,
  });

  factory HelpersBidModel.fromJson(Map<String, dynamic> json) =>
      _$HelpersBidModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelpersBidModelToJson(this);

  @JsonKey(name: 'helper_id')
  final String helperId;

  @JsonKey(name: 'neighbour_id')
  final String neighbourId;

  @JsonKey(name: 'job_id')
  final String jobId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'distance')
  final String distance;

  @JsonKey(name: 'distance_unit')
  final String distanceUnit;

  @JsonKey(name: '_id')
  final String Id;
}
