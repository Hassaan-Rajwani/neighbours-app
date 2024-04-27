part of 'dispute_bloc.dart';

abstract class DisputeState extends Equatable {
  const DisputeState();

  @override
  List<Object> get props => [];
}

class DisputeInitial extends DisputeState {}

class DisputeInProgress extends DisputeState {}

class DisputeError extends DisputeState {
  const DisputeError({required this.error});
  final String error;
}

class DisputeSuccessfull extends DisputeState {}
