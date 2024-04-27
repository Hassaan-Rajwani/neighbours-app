import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class AddressModel {
  AddressModel({
    required this.lat,
    required this.long,
    required this.streetName,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.label,
    required this.isDefault,
    required this.id,
    this.floor,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'long')
  final double long;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'state')
  final String state;

  @JsonKey(name: 'zip_code')
  final int zipCode;

  @JsonKey(name: 'label')
  final String label;

  @JsonKey(name: 'street_name')
  final String streetName;

  @JsonKey(name: 'unit_number')
  String? floor;

  @JsonKey(name: 'isDefault')
  bool isDefault;

  @JsonKey(name: '_id')
  final String id;
}
