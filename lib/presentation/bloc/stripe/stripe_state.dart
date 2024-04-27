part of 'stripe_bloc.dart';

abstract class AccountLoginState extends Equatable {
  const AccountLoginState();

  @override
  List<Object> get props => [];
}

class AccountLoginInitial extends AccountLoginState {}

class AccountLoginInProgress extends AccountLoginState {}

class AccountLoginSuccessfull extends AccountLoginState {
  const AccountLoginSuccessfull({required this.data});
  final HelperStripeModel data;
}

class AccountLoginError extends AccountLoginState {
  const AccountLoginError({required this.error});
  final String error;
}
