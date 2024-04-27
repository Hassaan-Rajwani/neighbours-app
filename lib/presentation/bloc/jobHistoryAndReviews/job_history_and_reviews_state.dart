part of 'job_history_and_reviews_bloc.dart';

sealed class JobHistoryAndReviewsState extends Equatable {
  const JobHistoryAndReviewsState();

  @override
  List<Object> get props => [];
}

final class JobHistoryAndReviewsInitial extends JobHistoryAndReviewsState {}

class GetJobHistoryAndReviewsInProgress extends JobHistoryAndReviewsState {}

class GetJobHistoryAndReviewsSuccessfull extends JobHistoryAndReviewsState {
  const GetJobHistoryAndReviewsSuccessfull({
    required this.reviewsList,
    required this.jobHistoryList,
  });
  final List<JobHistoryModel> jobHistoryList;
  final List<ReviewsModel> reviewsList;
}

class GetJobHistoryAndReviewsError extends JobHistoryAndReviewsState {
  const GetJobHistoryAndReviewsError({required this.error});
  final String error;
}
