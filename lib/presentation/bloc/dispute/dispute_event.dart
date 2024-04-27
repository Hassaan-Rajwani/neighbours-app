part of 'dispute_bloc.dart';

abstract class DisputeEvent extends Equatable {
  const DisputeEvent();

  @override
  List<Object> get props => [];
}

class CreateDisputeEvent extends DisputeEvent {
  const CreateDisputeEvent({
    required this.message,
    required this.jobId,
  });

  final String jobId;
  final Map<String, dynamic> message;
}
