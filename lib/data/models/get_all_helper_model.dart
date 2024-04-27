import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';

part 'get_all_helper_model.g.dart';

@JsonSerializable()
class AllHelpersModel {
  const AllHelpersModel({
    required this.id,
    required this.fisrtName,
    required this.lastName,
    required this.email,
    required this.helperInfo,
    required this.neighborInfo,
    required this.address,
    this.imageUrl,
    this.distance,
    this.distanceUnit,
    this.milesCategory,
  });

  factory AllHelpersModel.fromJson(Map<String, dynamic> json) =>
      _$AllHelpersModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllHelpersModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'first_name')
  final String fisrtName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'distance_unit')
  final String? distanceUnit;

  @JsonKey(name: 'distance')
  final double? distance;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'helper')
  final HelperRatingModel helperInfo;

  @JsonKey(name: 'neighbr')
  final HelperRatingModel neighborInfo;

  @JsonKey(name: 'address')
  final AddressModel address;

  @JsonKey(name: 'category')
  final HelperCategoryMilesModel? milesCategory;
}

@JsonSerializable()
class HelperCategoryMilesModel {
  const HelperCategoryMilesModel({
    required this.miles,
    this.label,
  });

  factory HelperCategoryMilesModel.fromJson(Map<String, dynamic> json) =>
      _$HelperCategoryMilesModelFromJson(json);
  Map<String, dynamic> toJson() => _$HelperCategoryMilesModelToJson(this);

  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'miles')
  final double miles;
}
