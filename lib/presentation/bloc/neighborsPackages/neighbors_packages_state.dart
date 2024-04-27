part of 'neighbors_packages_bloc.dart';

sealed class NeighborsPackagesState extends Equatable {
  const NeighborsPackagesState();

  @override
  List<Object> get props => [];
}

final class NeighborsPackagesInitial extends NeighborsPackagesState {}

class GetNeighborsPackageInProgress extends NeighborsPackagesState {}

class UpdateNeighborsPackageInProgress extends NeighborsPackagesState {}

class TipInProgress extends NeighborsPackagesState {}

class GetNeighborsSuccessfull extends NeighborsPackagesState {
  const GetNeighborsSuccessfull({required this.packageData});

  final List<NeighborsPackageModel> packageData;
}

class GiveTipSuccessfull extends NeighborsPackagesState {}

class GiveTipError extends NeighborsPackagesState {
  const GiveTipError({required this.error});
  final String error;
}
