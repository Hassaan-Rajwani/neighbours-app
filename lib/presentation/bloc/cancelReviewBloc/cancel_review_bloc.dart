import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/jobs/cancel_review.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'cancel_review_event.dart';
part 'cancel_review_state.dart';

class CancelReviewBloc extends Bloc<CancelReviewEvent, CancelReviewState> {
  CancelReviewBloc(this._createCancelReviewUseCase)
      : super(CancelReviewInitial()) {
    on<CreateCancelReviewEvent>(_createReview);
  }

  final CreateCancelReviewUseCase _createCancelReviewUseCase;

  Future<String?> _createReview(
    CreateCancelReviewEvent event,
    Emitter<CancelReviewState> emit,
  ) async {
    emit(CreateCancelReviewInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    final params = CreateCancelReviewBody(
      jobId: event.jobId,
      reviewBody: event.reviewBody,
      token: token!,
      isNeighbor: event.isNeighbor,
    );
    final dataState = await _createCancelReviewUseCase(params);
    if (dataState.data == null) {
      emit(CreateCancelReviewSuccessfull());
    } else {
      emit(CreateCancelReviewError(error: dataState.error!.message!));
    }
    return null;
  }
}
