// ignore_for_file: must_be_immutable

part of 'bids_bloc.dart';

sealed class BidsEvent extends Equatable {
  const BidsEvent();

  @override
  List<Object> get props => [];
}

final class GetNeighborBidsEvent extends BidsEvent {
  GetNeighborBidsEvent({required this.jobId});

  String jobId;
}

final class NeighborBidAcceptEvent extends BidsEvent {
  NeighborBidAcceptEvent({
    required this.token,
    required this.jobId,
    required this.bidId,
  });
  String token;
  String jobId;
  String bidId;
}

final class NeighborBidRejectEvent extends BidsEvent {
  NeighborBidRejectEvent({
    required this.token,
    required this.jobId,
    required this.bidId,
  });
  String token;
  String jobId;
  String bidId;
}
