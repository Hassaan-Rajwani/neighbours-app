import 'package:json_annotation/json_annotation.dart';

part 'get_neighbors_package.g.dart';

@JsonSerializable()
class NeighborsPackageModel {
  NeighborsPackageModel({
    required this.id,
    required this.helperId,
    required this.neighborsId,
    required this.jobId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.tipStatus,
    this.status,
  });

  factory NeighborsPackageModel.fromJson(Map<String, dynamic> json) =>
      _$NeighborsPackageModelFromJson(json);
  Map<String, dynamic> toJson() => _$NeighborsPackageModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'helper_id')
  final String helperId;

  @JsonKey(name: 'neighbour_id')
  final String neighborsId;

  @JsonKey(name: 'job_id')
  final String jobId;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'confirm_tip')
  final bool tipStatus;
}
