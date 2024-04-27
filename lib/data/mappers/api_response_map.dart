import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_map.g.dart';

@JsonSerializable()
class APIResponseMap {
  APIResponseMap({
    required this.data,
    required this.error,
  });

  factory APIResponseMap.fromJson(String jsonEncoded) {
    final json = jsonDecode(jsonEncoded) as Map<String, dynamic>;
    return _$APIResponseMapFromJson(json);
  }

  Map<String, dynamic> toJson() => _$APIResponseMapToJson(this);

  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  @JsonKey(name: 'isError')
  bool error;
}
