part of 'helper_package_bloc.dart';

sealed class HelperPackageState extends Equatable {
  const HelperPackageState();

  @override
  List<Object> get props => [];
}

final class PackageInitial extends HelperPackageState {}

class CreatePackageInprogress extends HelperPackageState {}

class CreatePackageSuccessfull extends HelperPackageState {}

class CreatePackageError extends HelperPackageState {
  const CreatePackageError({required this.error});
  final String error;
}

class GetPackageInprogress extends HelperPackageState {}

class GetPackageSuccessfull extends HelperPackageState {
  const GetPackageSuccessfull({required this.package});

  final List<NeighborsPackageModel> package;
  @override
  List<Object> get props => [package];
}

class GetPackageError extends HelperPackageState {
  const GetPackageError({required this.error});
  final String error;
}
