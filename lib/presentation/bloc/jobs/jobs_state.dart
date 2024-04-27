part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobsInitial extends JobsState {}

class GetActiveJobInprogress extends JobsState {}

class GetActiveJobSuccessfull extends JobsState {
  const GetActiveJobSuccessfull({required this.list});

  final List<JobModelWithHelperInfo> list;
}

class GetActiveJobError extends JobsState {
  const GetActiveJobError({required this.error});
  final String error;
}

class GetPendingJobInprogress extends JobsState {}

class GetPendingJobSuccessfull extends JobsState {
  const GetPendingJobSuccessfull({
    required this.pendingList,
    required this.activeList,
    required this.closeList,
  });
  final List<JobModel> pendingList;
  final List<JobModelWithHelperInfo> activeList;
  final List<JobModelWithHelperInfo> closeList;

  @override
  List<Object> get props => [pendingList, activeList, closeList];
}

class GetPendingJobError extends JobsState {
  const GetPendingJobError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class GetClosedJobInprogress extends JobsState {}

class GetClosedJobSuccessfull extends JobsState {
  const GetClosedJobSuccessfull({required this.list});

  final List<JobModelWithHelperInfo> list;
}

class GetClosedJobError extends JobsState {
  const GetClosedJobError({required this.error});
  final String error;
}

class CreatejobInprogress extends JobsState {}

class EditjobInprogress extends JobsState {}

class CreateJobSuccessfull extends JobsState {}

class EditJobSuccessfull extends JobsState {}

class CreateJobError extends JobsState {
  const CreateJobError({required this.error});
  final String error;
}

class EditJobError extends JobsState {
  const EditJobError({required this.error});
  final String error;
}

class PostCloseJobInprogress extends JobsState {}

class PostCloseJobSuccessfull extends JobsState {}

class PostCloseJobError extends JobsState {
  const PostCloseJobError({required this.error});
  final String error;
}

class CreateReviewInprogress extends JobsState {}

class CreateReviewSuccessfull extends JobsState {}

class CreateReviewError extends JobsState {
  const CreateReviewError({required this.error});
  final String error;
}
