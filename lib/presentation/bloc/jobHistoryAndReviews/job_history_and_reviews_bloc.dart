import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/job_history.dart';
import 'package:neighbour_app/data/models/reviews.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_job_history.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_user_review.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'job_history_and_reviews_event.dart';
part 'job_history_and_reviews_state.dart';

class JobHistoryAndReviewsBloc
    extends Bloc<JobHistoryAndReviewsEvent, JobHistoryAndReviewsState> {
  JobHistoryAndReviewsBloc(
    this._getJobHistoryUseCase,
    this._getHelperReviewsUsecase,
  ) : super(JobHistoryAndReviewsInitial()) {
    on<GetJobHistoryAndReviewsEvent>(_getJobHistory);
  }
  final GetJobHistoryUseCase _getJobHistoryUseCase;
  final GetReviewUseCase _getHelperReviewsUsecase;

  Future<void> _getJobHistory(
    GetJobHistoryAndReviewsEvent event,
    Emitter<JobHistoryAndReviewsState> emit,
  ) async {
    emit(GetJobHistoryAndReviewsInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params1 = GetJobHistoryParams(
        token: token,
        userId: event.userId,
        isNeighbr: event.isNeighbr,
      );
      final params2 = GetReviewParams(
        token: token,
        userId: event.userId,
        isNeighbr: event.isNeighbr,
      );
      final dataState = await _getJobHistoryUseCase(params1);
      final dataState2 = await _getHelperReviewsUsecase(params2);

      if (dataState.data != null && dataState2.data != null) {
        emit(
          GetJobHistoryAndReviewsSuccessfull(
            jobHistoryList: dataState.data!,
            reviewsList: dataState2.data!,
          ),
        );
      } else {
        emit(GetJobHistoryAndReviewsError(error: dataState.error!.message!));
      }
    }
  }
}
