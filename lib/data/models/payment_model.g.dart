// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeModel _$StripeModelFromJson(Map<String, dynamic> json) => StripeModel(
      setupIntent: StripeIntentModel.fromJson(
          json['setupIntent'] as Map<String, dynamic>),
      ephemeralSecretKey: json['ephemeralSecretKey'] as String,
    );

Map<String, dynamic> _$StripeModelToJson(StripeModel instance) =>
    <String, dynamic>{
      'setupIntent': instance.setupIntent,
      'ephemeralSecretKey': instance.ephemeralSecretKey,
    };

StripeIntentModel _$StripeIntentModelFromJson(Map<String, dynamic> json) =>
    StripeIntentModel(
      clientSecret: json['client_secret'] as String,
    );

Map<String, dynamic> _$StripeIntentModelToJson(StripeIntentModel instance) =>
    <String, dynamic>{
      'client_secret': instance.clientSecret,
    };
