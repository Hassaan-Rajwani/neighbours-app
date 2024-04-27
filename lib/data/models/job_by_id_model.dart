import 'package:json_annotation/json_annotation.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/data/models/favorite_data.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';

part 'job_by_id_model.g.dart';

@JsonSerializable()
class JobByIdModel {
  JobByIdModel({
    required this.id,
    required this.title,
    required this.type,
    required this.numberOfPackage,
    required this.size,
    required this.budget,
    required this.pickupType,
    required this.address,
    required this.description,
    required this.neighborId,
    required this.status,
    required this.bids,
    required this.packages,
    required this.isFavorite,
    required this.favorite,
    required this.createdAt,
    required this.updatedAt,
    this.helperId,
    this.raisedBy,
  });

  factory JobByIdModel.fromJson(Map<String, dynamic> json) =>
      _$JobByIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobByIdModelToJson(this);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'number_of_package')
  final int numberOfPackage;

  @JsonKey(name: 'size')
  final List<String> size;

  @JsonKey(name: 'budget')
  final int budget;

  @JsonKey(name: 'pickup_type')
  final List<String> pickupType;

  @JsonKey(name: 'address')
  final AddressModel address;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'neighbour_id')
  final String neighborId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'isFavorite')
  bool isFavorite;

  @JsonKey(name: 'favorite')
  final FavoriteDataModel? favorite;

  @JsonKey(name: 'bids')
  final List<dynamic> bids;

  @JsonKey(name: 'packets')
  final List<dynamic> packages;

  @JsonKey(name: 'helper_id')
  HelperIdModel? helperId;

  @JsonKey(name: 'raised_by')
  String? raisedBy;
}
