import 'package:json_annotation/json_annotation.dart';

part 'create_bid.g.dart';

@JsonSerializable()
class CreateBid {
  CreateBid({required this.amount});

  factory CreateBid.fromJson(Map<String, int> json) =>
      _$CreateBidFromJson(json);

  final int amount;

  Map<String, dynamic> toJson() => _$CreateBidToJson(this);
}
