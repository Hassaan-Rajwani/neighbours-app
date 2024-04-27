import 'package:json_annotation/json_annotation.dart';

part 'job_history.g.dart';

@JsonSerializable()
class JobHistoryModel {
  JobHistoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.amount = 0,
  });

  factory JobHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobHistoryModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'amount')
  int? amount;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;
}
