import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class EmailVerificationParams {
  EmailVerificationParams({required this.email, required this.otp});

  String otp;
  String email;
}

class EmailVerificationUseCase
    implements UseCase<String?, EmailVerificationParams> {
  EmailVerificationUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(EmailVerificationParams parms) {
    return _authenticationRepository.emailVerification(
      email: parms.email,
      otp: parms.otp,
    );
  }
}

class ResendEmailVerificationParams {
  ResendEmailVerificationParams({required this.email});

  String email;
}

class ResendEmailVerificationUseCase
    implements UseCase<String?, ResendEmailVerificationParams> {
  ResendEmailVerificationUseCase(this._authenticationRepository);
  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(ResendEmailVerificationParams parms) {
    return _authenticationRepository.resendEmailVerification(
      email: parms.email,
    );
  }
}
