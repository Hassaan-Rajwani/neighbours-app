import 'package:json_annotation/json_annotation.dart';

part 'helpers_count_job.g.dart';

@JsonSerializable()
class CountJobModel {
  const CountJobModel({required this.id});

  factory CountJobModel.fromJson(Map<String, dynamic> json) =>
      _$CountJobModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountJobModelToJson(this);

  @JsonKey(name: '_id')
  final String id;
}
