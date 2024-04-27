import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_all_active_jobs.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_all_closed_jobs.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_pending_jobs.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'helper_jobs_event.dart';
part 'helper_jobs_state.dart';

class HelperJobsBloc extends Bloc<HelperJobsEvent, HelperJobsState> {
  HelperJobsBloc(
    this._getAllPendingJobsUsecase,
    this._getAllActiveJobsUsecase,
    this._getAllClosedJobsUsecase,
  ) : super(HelperJobsInitial()) {
    on<GetHelperAllJobsEvent>(_getHelperAllJobs);
  }
  final GetAllPendingJobsUseCase _getAllPendingJobsUsecase;
  final GetAllActiveJobsUseCase _getAllActiveJobsUsecase;
  final GetAllClosedJobsUseCase _getAllClosedJobsUsecase;

  Future<void> _getHelperAllJobs(
    GetHelperAllJobsEvent event,
    Emitter<HelperJobsState> emit,
  ) async {
    emit(GetHelperAllJobsInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final pendingParams = GetAllPendingJobsBody(
        token: token,
        status: 'pending',
      );
      final activeParams = GetAllActiveJobsBody(
        token: token,
        status: 'active',
        rating: event.rating!,
        distance: event.distance!,
        order: event.order!,
        pickupType: event.pickupType!,
        size: event.size!,
      );
      final closedParams = GetAllClosedJobsBody(
        token: token,
        status: 'closed',
      );
      final dataState = await _getAllPendingJobsUsecase(pendingParams);
      final dataState2 = await _getAllActiveJobsUsecase(activeParams);
      final dataState3 = await _getAllClosedJobsUsecase(closedParams);
      if (dataState.data != null) {
        emit(
          GetHelperAllJobsSuccessfull(
            pendingList: dataState.data!,
            activeList: dataState2.data!,
            closeList: dataState3.data!,
          ),
        );
      } else {
        emit(GetHelperAllJobsError(error: dataState.error!.message!));
      }
    }
  }
}
