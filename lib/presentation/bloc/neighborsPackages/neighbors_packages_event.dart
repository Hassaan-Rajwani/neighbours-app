part of 'neighbors_packages_bloc.dart';

sealed class NeighborsPackagesEvent extends Equatable {
  const NeighborsPackagesEvent();

  @override
  List<Object> get props => [];
}

class GetNeighborsPackage extends NeighborsPackagesEvent {
  const GetNeighborsPackage({
    required this.jobId,
  });

  final String jobId;
}

class UpdateNeighborsPackage extends NeighborsPackagesEvent {
  const UpdateNeighborsPackage({
    required this.jobId,
    required this.packageId,
  });

  final String jobId;
  final String packageId;
}

class GiveTip extends NeighborsPackagesEvent {
  const GiveTip({
    required this.tipBody,
  });
  final Map<String, dynamic> tipBody;
}
