import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable()
class ReviewsModel {
  const ReviewsModel({
    required this.id,
    required this.jobId,
    required this.detail,
    required this.rate,
    required this.neighbor,
    required this.createdAt,
    required this.updatedAt,
    required this.helper,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'job')
  final String jobId;

  @JsonKey(name: 'detail')
  final String detail;

  @JsonKey(name: 'rate')
  final double rate;

  @JsonKey(name: 'neighbour')
  final dynamic neighbor;

  @JsonKey(name: 'helper')
  final dynamic helper;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;
}
