// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponseMap _$APIResponseMapFromJson(Map<String, dynamic> json) =>
    APIResponseMap(
      data: json['data'] as Map<String, dynamic>?,
      error: json['isError'] as bool,
    );

Map<String, dynamic> _$APIResponseMapToJson(APIResponseMap instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isError': instance.error,
    };
