import 'package:json_annotation/json_annotation.dart';

part 'helper_stripe_model.g.dart';

@JsonSerializable()
class HelperStripeModel {
  HelperStripeModel({
    required this.loginUrl,
  });

  factory HelperStripeModel.fromJson(Map<String, dynamic> json) =>
      _$HelperStripeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperStripeModelToJson(this);

  @JsonKey(name: 'url')
  final String loginUrl;
}
