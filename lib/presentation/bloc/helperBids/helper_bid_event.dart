// ignore_for_file: must_be_immutable
part of 'helper_bid_bloc.dart';

sealed class HelperBidEvent extends Equatable {
  const HelperBidEvent();

  @override
  List<Object> get props => [];
}

final class HelperCreateBidEvent extends HelperBidEvent {
  HelperCreateBidEvent({
    required this.token,
    required this.bidId,
    required this.body,
  });
  String token;
  String bidId;
  Map<String, dynamic> body;
}

final class HelperRejectBidEvent extends HelperBidEvent {
  HelperRejectBidEvent({
    required this.token,
    required this.jobId,
  });
  String token;
  String jobId;
}
