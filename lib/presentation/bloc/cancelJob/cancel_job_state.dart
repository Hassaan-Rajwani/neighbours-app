part of 'cancel_job_bloc.dart';

abstract class CancelJobState extends Equatable {
  const CancelJobState();

  @override
  List<Object> get props => [];
}

final class PostCancelJobInitial extends CancelJobState {}

class PostCancelJobInprogress extends CancelJobState {}

class PostCancelJobSuccessfull extends CancelJobState {}

class PostCancelJobError extends CancelJobState {
  const PostCancelJobError({required this.error});
  final String error;
}
