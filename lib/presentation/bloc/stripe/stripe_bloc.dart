import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/helper_stripe_model.dart';
import 'package:neighbour_app/domain/usecases/stripe/add_card.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'stripe_event.dart';
part 'stripe_state.dart';

class StripeBloc extends Bloc<AddStripeEvent, AccountLoginState> {
  StripeBloc(
    this._addStripeUseCase,
  ) : super(AccountLoginInitial()) {
    on<AddStripeEvent>(_addStripe);
  }

  final AddStripeUseCase _addStripeUseCase;

  Future<void> _addStripe(
    AddStripeEvent event,
    Emitter<AccountLoginState> emit,
  ) async {
    emit(AccountLoginInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _addStripeUseCase(token);
      if (dataState.data != null) {
        emit(AccountLoginSuccessfull(data: dataState.data!));
      } else {
        emit(
          AccountLoginError(
            error: dataState.error!.message!,
          ),
        );
      }
    }
  }
}
