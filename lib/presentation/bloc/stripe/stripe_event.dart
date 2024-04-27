part of 'stripe_bloc.dart';

abstract class AccountLoginEvent extends Equatable {
  const AccountLoginEvent();

  @override
  List<Object> get props => [];
}

class AddStripeEvent extends AccountLoginEvent {
  const AddStripeEvent({required this.token});
  final String token;
}
