import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/another_user_model.dart';
import 'package:neighbour_app/domain/usecases/helper/get_another_user.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'get_another_user_event.dart';
part 'get_another_user_state.dart';

class GetAnotherUserBloc
    extends Bloc<GetAnotherUserEvent, GetAnotherUserState> {
  GetAnotherUserBloc(this._getAnotherUserUseCase)
      : super(GetAnotherUserInitial()) {
    on<GetAnotherUser>(_getAnotherUser);
  }
  final GetAnotherUserUseCase _getAnotherUserUseCase;

  Future<void> _getAnotherUser(
    GetAnotherUser event,
    Emitter<GetAnotherUserState> emit,
  ) async {
    emit(GetAnotherUserInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetAnotherUserParams(
        token: token,
        helperId: event.helperId,
      );
      final dataState = await _getAnotherUserUseCase(params);
      if (dataState.data != null) {
        emit(GetAnotherUserSuccessfull(helperId: dataState.data!));
      } else {
        emit(GetAnotherUserError(error: dataState.error!.message!));
      }
    }
  }
}
