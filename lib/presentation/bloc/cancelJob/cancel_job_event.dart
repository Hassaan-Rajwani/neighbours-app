part of 'cancel_job_bloc.dart';

abstract class CancelJobEvent extends Equatable {
  const CancelJobEvent();

  @override
  List<Object> get props => [];
}

class PostCancelJobEvent extends CancelJobEvent {
  const PostCancelJobEvent({
    required this.reason,
    required this.jobId,
  });
  final String jobId;
  final Map<String, dynamic> reason;
}
