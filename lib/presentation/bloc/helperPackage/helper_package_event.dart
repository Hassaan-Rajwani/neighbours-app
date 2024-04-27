part of 'helper_package_bloc.dart';

sealed class HelperPackageEvent extends Equatable {
  const HelperPackageEvent();

  @override
  List<Object> get props => [];
}

class CreatePackageEvent extends HelperPackageEvent {
  const CreatePackageEvent({
    required this.jobId,
    required this.body,
  });
  final String jobId;
  final Map<String, dynamic> body;
}

class GetPackageEvent extends HelperPackageEvent {
  const GetPackageEvent({required this.jobId});

  final String jobId;
}
