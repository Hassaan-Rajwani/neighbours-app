part of 'payment_intents_bloc.dart';

sealed class PaymentIntentsState extends Equatable {
  const PaymentIntentsState();

  @override
  List<Object> get props => [];
}

final class PaymentIntentsInitial extends PaymentIntentsState {}

class PaymentIntentSuccessfully extends PaymentIntentsState {
  const PaymentIntentSuccessfully({required this.data});

  final StripeModel data;
  @override
  List<Object> get props => [data];
}

class PaymentIntentError extends PaymentIntentsState {
  const PaymentIntentError({required this.error});
  final String error;
}
