import 'package:json_annotation/json_annotation.dart';

part 'helper_package.g.dart';

@JsonSerializable()
class HelperPackage {
  HelperPackage({required this.imageUrl});

  factory HelperPackage.fromJson(Map<String, String> json) =>
      _$HelperPackageFromJson(json);

  @JsonKey(name: 'image_url')
  final String imageUrl;

  Map<String, dynamic> toJson() => _$HelperPackageToJson(this);
}
