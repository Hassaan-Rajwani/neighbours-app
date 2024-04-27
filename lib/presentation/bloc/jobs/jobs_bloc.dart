// ignore_for_file: body_might_complete_normally_nullable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/data/models/jobs_model.dart';
import 'package:neighbour_app/domain/usecases/jobs/create_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/create_review.dart';
import 'package:neighbour_app/domain/usecases/jobs/edit_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_active_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_closed_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_pending_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/post_close_job.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc(
    this._getAtiveJobUseCase,
    this._getPendingJobUseCase,
    this._getClosedJobUseCase,
    this._createJobUseCase,
    this._editJobUseCase,
    this._postCloseJobUseCase,
    this._createReviewUseCase,
  ) : super(JobsInitial()) {
    on<GetPendingJobEvent>(_getPendingJob);
    on<GetClosedJobEvent>(_getClosedJob);
    on<CreateJobEvent>(_createJob);
    on<EditJobEvent>(_editJob);
    on<PostCloseJobEvent>(_postClosejob);
    on<CreateReviewEvent>(_createReview);
  }

  final GetAtiveJobUseCase _getAtiveJobUseCase;
  final GetPendingJobUseCase _getPendingJobUseCase;
  final GetClosedJobUseCase _getClosedJobUseCase;
  final CreateJobUseCase _createJobUseCase;
  final EditJobUseCase _editJobUseCase;
  final PostCloseJobUseCase _postCloseJobUseCase;
  final CreateReviewUseCase _createReviewUseCase;

  Future<void> _getPendingJob(
    GetPendingJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(GetPendingJobInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetActiveBody(
        token: token,
        rating: event.rating!,
        distance: event.distance!,
        order: event.order!,
        pickupType: event.pickupType!,
        size: event.size!,
      );
      final dataState = await _getPendingJobUseCase(token);
      final dataState2 = await _getAtiveJobUseCase(params);
      final dataState3 = await _getClosedJobUseCase(token);
      if (dataState.data != null &&
          dataState2.data != null &&
          dataState3.data != null) {
        emit(
          GetPendingJobSuccessfull(
            pendingList: dataState.data!,
            activeList: dataState2.data!,
            closeList: dataState3.data!,
          ),
        );
      } else {
        emit(GetPendingJobError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _getClosedJob(
    GetClosedJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(GetClosedJobInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getClosedJobUseCase(token);
      if (dataState.data != null) {
        emit(GetClosedJobSuccessfull(list: dataState.data!));
      } else {
        emit(GetClosedJobError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _createJob(
    CreateJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(CreatejobInprogress());
    final params = CreateJobBody(
      body: event.jobBody,
      token: event.token,
    );
    final dataState = await _createJobUseCase(params);
    if (dataState.data == null) {
      emit(CreateJobSuccessfull());
    } else {
      emit(CreateJobError(error: dataState.error!.message!));
    }
  }

  Future<void> _editJob(
    EditJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(EditjobInprogress());
    final params = EditJobBody(
      body: event.jobBody,
      token: event.token,
      jobId: event.jobId,
    );
    final dataState = await _editJobUseCase(params);
    if (dataState.data == null) {
      emit(EditJobSuccessfull());
    } else {
      emit(EditJobError(error: dataState.error!.message!));
    }
  }

  Future<JobModel?> _postClosejob(
    PostCloseJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(PostCloseJobInprogress());
    final params = PostCloseJobBody(token: event.token, jobId: event.jobId);
    final dataState = await _postCloseJobUseCase(params);
    if (dataState.data != null) {
      emit(CreateJobSuccessfull());
    } else {
      emit(CreateJobError(error: dataState.error!.message!));
    }
  }

  Future<String?> _createReview(
    CreateReviewEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(CreateReviewInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    final params = CreateReviewBody(
      jobId: event.jobId,
      reviewBody: event.reviewBody,
      token: token!,
    );
    final dataState = await _createReviewUseCase(params);
    if (dataState.data == null) {
      emit(CreateReviewSuccessfull());
    } else {
      emit(CreateReviewError(error: dataState.error!.message!));
    }
  }
}
