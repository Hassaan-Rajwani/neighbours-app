part of 'cancel_review_bloc.dart';

sealed class CancelReviewState extends Equatable {
  const CancelReviewState();

  @override
  List<Object> get props => [];
}

final class CancelReviewInitial extends CancelReviewState {}

class CreateCancelReviewInprogress extends CancelReviewState {}

class CreateCancelReviewSuccessfull extends CancelReviewState {}

class CreateCancelReviewError extends CancelReviewState {
  const CreateCancelReviewError({required this.error});
  final String error;
}
