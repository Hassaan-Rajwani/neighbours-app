import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/payment_model.dart';
import 'package:neighbour_app/domain/usecases/cards/add_card.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'payment_intents_event.dart';
part 'payment_intents_state.dart';

class PaymentIntentsBloc
    extends Bloc<PaymentIntentsEvent, PaymentIntentsState> {
  PaymentIntentsBloc(this._setupPaymentIntentUseCase)
      : super(PaymentIntentsInitial()) {
    on<SetPaymentIntentEvent>(_setupPaymentIntents);
  }
  final AddCardUseCase _setupPaymentIntentUseCase;

  Future<void> _setupPaymentIntents(
    SetPaymentIntentEvent event,
    Emitter<PaymentIntentsState> emit,
  ) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _setupPaymentIntentUseCase(token);
      if (dataState.data != null) {
        emit(PaymentIntentSuccessfully(data: dataState.data!));
      } else {
        emit(
          PaymentIntentError(
            error: dataState.error!.message!,
          ),
        );
      }
    }
  }
}
