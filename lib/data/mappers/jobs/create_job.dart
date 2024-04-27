import 'package:json_annotation/json_annotation.dart';

part 'create_job.g.dart';

@JsonSerializable()
class CreateJob {
  CreateJob(
    this.title,
    this.type,
    this.numberOfPackages,
    this.budget,
    this.pickupType,
    this.description,
    this.address, {
    required this.size,
  });

  factory CreateJob.fromJson(Map<String, dynamic> json) =>
      _$CreateJobFromJson(json);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'number_of_package')
  final int numberOfPackages;
  @JsonKey(name: 'size')
  final List<String> size;
  @JsonKey(name: 'budget')
  final int budget;
  @JsonKey(name: 'pickup_type')
  final List<String> pickupType;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'address')
  final String address;

  Map<String, dynamic> toJson() => _$CreateJobToJson(this);
}
