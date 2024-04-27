part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateOnboarding extends AuthState {}

class AuthStateSignInProgress extends AuthState {}

class GoogleAuthInProgress extends AuthState {}

class GoogleAuthSuccessful extends AuthState {}

class GoogleAuthError extends AuthState {
  const GoogleAuthError(this.error);
  final String error;
}

class AuthStateSignInSuccessful extends AuthState {}

class AuthStateUserType extends AuthState {
  const AuthStateUserType({this.userType = 'Neighbor'});
  final String userType;

  @override
  List<Object> get props => [userType];
}

class AuthStateSignInError extends AuthState {
  const AuthStateSignInError(this.error);
  final String error;
}

class AuthStateSignedOut extends AuthState {}

class AuthStateSignedOutError extends AuthState {}

class AuthStateSignedOutInProgress extends AuthState {}

class AuthStateResendEmailVerifiedSuccessfully extends AuthState {}

class AuthStateForgotPasswordSuccessfully extends AuthState {}

class AuthStateForgotPasswordResendCodeSuccessfully extends AuthState {}

class AuthStateResetPasswordSuccessfully extends AuthState {}

class AuthStateChangePasswordSuccessfully extends AuthState {}

class AuthStateResendEmailVerifiedError extends AuthState {
  const AuthStateResendEmailVerifiedError(this.error);
  final String error;
}

class AuthStateForgotPasswordError extends AuthState {
  const AuthStateForgotPasswordError(this.error);
  final String error;
}

class AuthStateForgotPasswordResendCodeError extends AuthState {
  const AuthStateForgotPasswordResendCodeError(this.error);
  final String error;
}

class AuthStateForgotPasswordInProgress extends AuthState {}

class AuthStateResetPasswordError extends AuthState {
  const AuthStateResetPasswordError(this.error);
  final String error;
}

class AuthStateChangePasswordError extends AuthState {
  const AuthStateChangePasswordError(this.error);
  final String error;
}

class AuthStateResetPasswordInProgress extends AuthState {}

class AuthStateChangePasswordInProgress extends AuthState {}

class AuthStateSignUpInProgress extends AuthState {}

class AuthStateSignUpSuccessful extends AuthState {
  const AuthStateSignUpSuccessful({required this.email});
  final String email;
}

class AuthStateSignUpError extends AuthState {
  const AuthStateSignUpError(this.error);
  final String error;
}

class AuthStateEmailVerifiedSuccessfully extends AuthState {}

class ConfirmEmailOnLoginState extends AuthState {
  const ConfirmEmailOnLoginState({required this.email});
  final String email;
}

class AuthStateEmailVerificationProgress extends AuthState {}

class AuthStateEmailVerifiedError extends AuthState {
  const AuthStateEmailVerifiedError(this.error);
  final String error;
}

class AccountDeactivateInProgress extends AuthState {}

class AccountDeactivateSuccessfully extends AuthState {}

class AccountDeactivateError extends AuthState {
  const AccountDeactivateError({required this.error});
  final String error;
}
