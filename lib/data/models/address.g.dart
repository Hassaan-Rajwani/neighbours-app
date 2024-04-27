// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      streetName: json['street_name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zip_code'] as int,
      label: json['label'] as String,
      isDefault: json['isDefault'] as bool,
      id: json['_id'] as String,
      floor: json['unit_number'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'city': instance.city,
      'state': instance.state,
      'zip_code': instance.zipCode,
      'label': instance.label,
      'street_name': instance.streetName,
      'unit_number': instance.floor,
      'isDefault': instance.isDefault,
      '_id': instance.id,
    };
