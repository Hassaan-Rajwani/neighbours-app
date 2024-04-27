import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class StripeModel {
  StripeModel({
    required this.setupIntent,
    required this.ephemeralSecretKey,
  });

  factory StripeModel.fromJson(Map<String, dynamic> json) =>
      _$StripeModelFromJson(json);
  Map<String, dynamic> toJson() => _$StripeModelToJson(this);

  @JsonKey(name: 'setupIntent')
  final StripeIntentModel setupIntent;

  @JsonKey(name: 'ephemeralSecretKey')
  final String ephemeralSecretKey;
}

@JsonSerializable()
class StripeIntentModel {
  StripeIntentModel({
    required this.clientSecret,
  });

  factory StripeIntentModel.fromJson(Map<String, dynamic> json) =>
      _$StripeIntentModelFromJson(json);
  Map<String, dynamic> toJson() => _$StripeIntentModelToJson(this);

  @JsonKey(name: 'client_secret')
  final String clientSecret;
}
