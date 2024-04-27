import 'package:json_annotation/json_annotation.dart';

part 'create_review.g.dart';

@JsonSerializable()
class CreateReview {
  CreateReview({required this.detail, required this.rate});

  factory CreateReview.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewFromJson(json);

  @JsonKey(name: 'rate')
  final int rate;

  @JsonKey(name: 'detail')
  final int detail;

  Map<String, dynamic> toJson() => _$CreateReviewToJson(this);
}
