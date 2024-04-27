part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object> get props => [];
}

class GetActiveJobEvent extends JobsEvent {}

class GetPendingJobEvent extends JobsEvent {
  const GetPendingJobEvent({
    this.rating = 0,
    this.size = 'null',
    this.order = 'null',
    this.pickupType = 'null',
    this.distance = 0.0,
  });
  final int? rating;
  final String? size;
  final String? order;
  final String? pickupType;
  final double? distance;
}

class GetClosedJobEvent extends JobsEvent {}

class CreateJobEvent extends JobsEvent {
  const CreateJobEvent({required this.token, required this.jobBody});
  final String token;
  final Map<String, dynamic> jobBody;
}

class EditJobEvent extends JobsEvent {
  const EditJobEvent({
    required this.token,
    required this.jobBody,
    required this.jobId,
  });
  final String token;
  final Map<String, dynamic> jobBody;
  final String jobId;
}

class PostCloseJobEvent extends JobsEvent {
  const PostCloseJobEvent({required this.token, required this.jobId});
  final String token;
  final String jobId;
}

class CreateReviewEvent extends JobsEvent {
  const CreateReviewEvent({
    required this.jobId,
    required this.reviewBody,
  });
  final String jobId;
  final Map<String, dynamic> reviewBody;
}
