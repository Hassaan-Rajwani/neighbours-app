part of 'cancel_review_bloc.dart';

sealed class CancelReviewEvent extends Equatable {
  const CancelReviewEvent();

  @override
  List<Object> get props => [];
}

class CreateCancelReviewEvent extends CancelReviewEvent {
  const CreateCancelReviewEvent({
    required this.jobId,
    required this.reviewBody,
    required this.isNeighbor,
  });
  final String jobId;
  final bool isNeighbor;
  final Map<String, dynamic> reviewBody;
}
