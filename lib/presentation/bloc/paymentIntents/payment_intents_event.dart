part of 'payment_intents_bloc.dart';

sealed class PaymentIntentsEvent extends Equatable {
  const PaymentIntentsEvent();

  @override
  List<Object> get props => [];
}

class SetPaymentIntentEvent extends PaymentIntentsEvent {}
