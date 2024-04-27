import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class ForgotPasswordParams {
  ForgotPasswordParams({required this.email});

  String email;
}

class ForgotPasswordUseCase implements UseCase<String?, ForgotPasswordParams> {
  ForgotPasswordUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(ForgotPasswordParams parms) {
    return _authenticationRepository.forgotPassword(email: parms.email);
  }
}

class ForgotPasswordResendCodeParams {
  ForgotPasswordResendCodeParams({required this.email});

  String email;
}

class ForgotPasswordResendCodeUseCase
    implements UseCase<String?, ForgotPasswordResendCodeParams> {
  ForgotPasswordResendCodeUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(ForgotPasswordResendCodeParams parms) {
    return _authenticationRepository.forgotPasswordResendCode(
      email: parms.email,
    );
  }
}
