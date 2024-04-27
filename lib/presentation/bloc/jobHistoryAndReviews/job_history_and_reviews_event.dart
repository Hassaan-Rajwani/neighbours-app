part of 'job_history_and_reviews_bloc.dart';

sealed class JobHistoryAndReviewsEvent extends Equatable {
  const JobHistoryAndReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetJobHistoryAndReviewsEvent extends JobHistoryAndReviewsEvent {
  const GetJobHistoryAndReviewsEvent({
    required this.userId,
    required this.isNeighbr,
  });
  final String userId;
  final bool isNeighbr;
}
