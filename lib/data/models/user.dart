import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.email,
    required this.active,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cognitoID,
    required this.stripeHelperAccountID,
    required this.stripeCustomerAccountID,
    required this.bankDetails,
    this.description,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'active')
  final bool active;

  @JsonKey(name: 'detailed_submitted')
  final bool bankDetails;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'cognito_id')
  final String cognitoID;

  @JsonKey(name: 'stripe_connect_id')
  final String stripeHelperAccountID;

  @JsonKey(name: 'stripe_customer_id')
  final String stripeCustomerAccountID;

  @JsonKey(name: 'image_url')
  final String? imageUrl;
}
