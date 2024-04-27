// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponseList _$APIResponseListFromJson(Map<String, dynamic> json) =>
    APIResponseList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      error: json['isError'] as bool,
    );

Map<String, dynamic> _$APIResponseListToJson(APIResponseList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isError': instance.error,
    };
