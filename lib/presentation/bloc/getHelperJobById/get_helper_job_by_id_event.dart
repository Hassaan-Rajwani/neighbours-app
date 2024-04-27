part of 'get_helper_job_by_id_bloc.dart';

sealed class GetHelperJobByIdEvent extends Equatable {
  const GetHelperJobByIdEvent();

  @override
  List<Object> get props => [];
}

class GetHelperJobEvent extends GetHelperJobByIdEvent {
  const GetHelperJobEvent({
    required this.jobId,
  });

  final String jobId;
}
