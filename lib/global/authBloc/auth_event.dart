abstract class AuthEvent {
  const AuthEvent();
}

class AuthSplashEvent extends AuthEvent {}

class AuthUserTypeEvent extends AuthEvent {
  AuthUserTypeEvent({required this.type});

  final String type;
}

class AuthLogoutEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  AuthSignInEvent({required this.email, required this.password});

  String email;
  String password;
}

class GoogleAuthEvent extends AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.lastName,
    required this.firstName,
  });

  String email;
  String password;
  String lastName;
  String firstName;
}

class AuthForgotPasswordEvent extends AuthEvent {
  AuthForgotPasswordEvent({required this.email});

  String email;
}

class AuthForgotPasswordResendCodeEvent extends AuthEvent {
  AuthForgotPasswordResendCodeEvent({required this.email});

  String email;
}

class AuthResendVerificationEmailEvent extends AuthEvent {
  AuthResendVerificationEmailEvent({required this.email});

  String email;
}

class AuthVerificationEmailEvent extends AuthEvent {
  AuthVerificationEmailEvent({required this.email, required this.otp});

  String email;
  String otp;
}

class AuthResetPassword extends AuthEvent {
  AuthResetPassword({
    required this.otp,
    required this.email,
    required this.newPassword,
  });

  String otp;
  String email;
  String newPassword;
}

class AccountDeactivateEvent extends AuthEvent {
  AccountDeactivateEvent({
    required this.body,
  });

  Map<String, dynamic> body;
}

class AuthChangePassword extends AuthEvent {
  AuthChangePassword({
    required this.oldPassword,
    required this.newPassword,
  });

  String oldPassword;
  String newPassword;
}
