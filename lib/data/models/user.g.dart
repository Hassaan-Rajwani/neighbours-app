// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      active: json['active'] as bool,
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      cognitoID: json['cognito_id'] as String,
      stripeHelperAccountID: json['stripe_connect_id'] as String,
      stripeCustomerAccountID: json['stripe_customer_id'] as String,
      bankDetails: json['detailed_submitted'] as bool,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'active': instance.active,
      'detailed_submitted': instance.bankDetails,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'description': instance.description,
      'cognito_id': instance.cognitoID,
      'stripe_connect_id': instance.stripeHelperAccountID,
      'stripe_customer_id': instance.stripeCustomerAccountID,
      'image_url': instance.imageUrl,
    };
