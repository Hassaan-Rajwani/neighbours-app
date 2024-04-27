// ignore_for_file: body_might_complete_normally_nullable, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/cancelJob/postCancelJob.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'cancel_job_event.dart';
part 'cancel_job_state.dart';

class CancelJobBloc extends Bloc<CancelJobEvent, CancelJobState> {
  CancelJobBloc(
    this._postCancelJobUseCase,
  ) : super(PostCancelJobInitial()) {
    on<PostCancelJobEvent>(_postCancelJob);
  }

  final PostCancelJobUseCase _postCancelJobUseCase;

  Future<String?> _postCancelJob(
    PostCancelJobEvent event,
    Emitter<CancelJobState> emit,
  ) async {
    emit(PostCancelJobInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = PostCancelJobBody(
        token: token,
        jobId: event.jobId,
        body: event.reason,
      );
      final dataState = await _postCancelJobUseCase(params);
      if (dataState.data != null) {
        emit(PostCancelJobSuccessfull());
      } else {
        emit(PostCancelJobError(error: dataState.error!.message!));
      }
    }
  }
}
