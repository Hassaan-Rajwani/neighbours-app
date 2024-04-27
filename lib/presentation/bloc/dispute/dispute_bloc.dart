import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/dispute/create_dispute.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'dispute_event.dart';
part 'dispute_state.dart';

class DisputeBloc extends Bloc<DisputeEvent, DisputeState> {
  DisputeBloc(
    this._createDisputeUseCase,
  ) : super(DisputeInitial()) {
    on<CreateDisputeEvent>(_createDispute);
  }

  final CreateDisputeUseCase _createDisputeUseCase;

  Future<Map<String, dynamic>?> _createDispute(
    CreateDisputeEvent event,
    Emitter<DisputeState> emit,
  ) async {
    emit(DisputeInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = CreateDisputeParams(
        body: event.message,
        token: token,
        jobId: event.jobId,
      );
      final dataState = await _createDisputeUseCase(params);
      if (dataState.data == null) {
        emit(DisputeSuccessfull());
      } else {
        emit(DisputeError(error: dataState.error!.message!));
      }
    }
    return null;
  }
}
