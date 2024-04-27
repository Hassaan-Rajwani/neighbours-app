import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_job_by_id.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'get_by_id_event.dart';
part 'get_by_id_state.dart';

class GetByIdBloc extends Bloc<GetByIdEvent, GetByIdState> {
  GetByIdBloc(this._getJobByIdUseCase) : super(GetByIdInitial()) {
    on<GetJobByIdEvent>(_getJobById);
  }

  final GetJobByIdUseCase _getJobByIdUseCase;

  Future<void> _getJobById(
    GetJobByIdEvent event,
    Emitter<GetByIdState> emit,
  ) async {
    emit(GetJobByIdInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetJobByIdParams(
        name: 'neighbour',
        token: token,
        jobId: event.jobId,
      );
      final dataState = await _getJobByIdUseCase(params);
      if (dataState.data != null) {
        emit(GetJobByIdSuccessfull(job: dataState.data!));
      } else {
        emit(GetJobByIdError(error: dataState.error!.message!));
      }
    }
  }
}
