part of 'get_helper_job_by_id_bloc.dart';

sealed class GetHelperJobByIdState extends Equatable {
  const GetHelperJobByIdState();

  @override
  List<Object> get props => [];
}

final class GetHelperJobByIdInitial extends GetHelperJobByIdState {}

class GetHelperJobByIdSuccessfull extends GetHelperJobByIdState {
  const GetHelperJobByIdSuccessfull({required this.job});
  final HelperJobModel job;
}

class GetHelperJobByIdError extends GetHelperJobByIdState {
  const GetHelperJobByIdError({required this.error});
  final String error;
}

class GetHelperJobByIdInprogress extends GetHelperJobByIdState {}
