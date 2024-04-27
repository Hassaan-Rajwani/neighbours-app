import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';
import 'package:neighbour_app/domain/usecases/helper/get_all_helper_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'all_helper_event.dart';
part 'all_helper_state.dart';

class AllHelperBloc extends Bloc<AllHelperEvent, AllHelperState> {
  AllHelperBloc(this._getHelpersListUseCase) : super(AllHelperInitial()) {
    on<GetAllHelpersEvent>(_getAllHelperList);
  }

  final GetAllHelperUseCase _getHelpersListUseCase;

  Future<void> _getAllHelperList(
    GetAllHelpersEvent event,
    Emitter<AllHelperState> emit,
  ) async {
    emit(GetHelperInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetHelpersBody(
        miles: event.miles,
        rating: event.rating,
        token: token,
      );
      final dataState = await _getHelpersListUseCase(params);
      if (dataState.data != null) {
        emit(AllHelperStateSuccessful(list: dataState.data!));
      } else {
        emit(GetHelperError(error: dataState.error!.message!));
      }
    }
  }
}
