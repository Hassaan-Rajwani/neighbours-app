part of 'bids_bloc.dart';

sealed class BidsState extends Equatable {
  const BidsState();

  @override
  List<Object> get props => [];
}

final class BidsInitial extends BidsState {}

final class GetNeighborBidsInprogress extends BidsState {}

final class GetNeighborBidsSuccessfull extends BidsState {
  const GetNeighborBidsSuccessfull({
    required this.list,
  });

  final List<BidsModel> list;
}

final class GetNeighborBidsError extends BidsState {
  const GetNeighborBidsError(this.error);
  final String error;
}

final class NeighborBidAcceptInprogress extends BidsState {}

final class NeighborBidRejectInprogress extends BidsState {}

final class NeighborBidAcceptSuccessfull extends BidsState {}

final class NeighborBidRejectSuccessfull extends BidsState {}

final class NeighborBidAcceptError extends BidsState {
  const NeighborBidAcceptError(this.error);
  final String error;
}

final class NeighborBidRejectError extends BidsState {
  const NeighborBidRejectError(this.error);
  final String error;
}
