part of 'helper_bid_bloc.dart';

sealed class HelperBidState extends Equatable {
  const HelperBidState();

  @override
  List<Object> get props => [];
}

final class HelperBidInitial extends HelperBidState {}

final class HelperCreateBidSuccessfull extends HelperBidState {}

final class HelperCreateBidError extends HelperBidState {
  const HelperCreateBidError(this.error);
  final String error;
}
