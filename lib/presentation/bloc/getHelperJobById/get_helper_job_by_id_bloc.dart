import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_helper_job_by_id.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'get_helper_job_by_id_event.dart';
part 'get_helper_job_by_id_state.dart';

class GetHelperJobByIdBloc
    extends Bloc<GetHelperJobByIdEvent, GetHelperJobByIdState> {
  GetHelperJobByIdBloc(this._getJobByIdUseCase)
      : super(GetHelperJobByIdInitial()) {
    on<GetHelperJobEvent>(_getJobById);
  }

  final GetHelperJobByIdUseCase _getJobByIdUseCase;

  Future<void> _getJobById(
    GetHelperJobEvent event,
    Emitter<GetHelperJobByIdState> emit,
  ) async {
    emit(GetHelperJobByIdInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetHelperJobByIdParams(
        name: 'helper',
        token: token,
        jobId: event.jobId,
      );
      final dataState = await _getJobByIdUseCase(params);
      if (dataState.data != null) {
        emit(GetHelperJobByIdSuccessfull(job: dataState.data!));
      } else {
        emit(GetHelperJobByIdError(error: dataState.error!.message!));
      }
    }
  }
}
