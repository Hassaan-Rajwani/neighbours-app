import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_list.g.dart';

@JsonSerializable()
class APIResponseList {
  APIResponseList({
    required this.data,
    required this.error,
  });

  factory APIResponseList.fromJson(String jsonEncoded) {
    final json = jsonDecode(jsonEncoded) as Map<String, dynamic>;
    return _$APIResponseListFromJson(json);
  }

  Map<String, dynamic>? toJson() => _$APIResponseListToJson(this);

  @JsonKey(name: 'data')
  List<Map<String, dynamic>>? data;
  @JsonKey(name: 'isError')
  bool error;
}
