part of 'helper_jobs_bloc.dart';

sealed class HelperJobsState extends Equatable {
  const HelperJobsState();

  @override
  List<Object> get props => [];
}

final class HelperJobsInitial extends HelperJobsState {}

class GetHelperAllJobsInprogress extends HelperJobsState {}

class GetHelperAllJobsSuccessfull extends HelperJobsState {
  const GetHelperAllJobsSuccessfull({
    required this.pendingList,
    required this.activeList,
    required this.closeList,
  });

  final List<HelpersPendingJobModel> pendingList;
  final List<HelperActiveJobModel> activeList;
  final List<HelperActiveJobModel> closeList;
}

class GetHelperAllJobsError extends HelperJobsState {
  const GetHelperAllJobsError({required this.error});

  final String error;
}
