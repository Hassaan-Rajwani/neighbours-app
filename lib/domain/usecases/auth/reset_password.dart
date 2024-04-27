import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class ResetPasswordParams {
  ResetPasswordParams({
    required this.otp,
    required this.email,
    required this.newPassword,
  });

  String otp;
  String email;
  String newPassword;
}

class ResetPasswordUseCase implements UseCase<String?, ResetPasswordParams> {
  ResetPasswordUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(ResetPasswordParams parms) {
    return _authenticationRepository.resetPassword(
      otp: parms.otp,
      email: parms.email,
      newPassword: parms.newPassword,
    );
  }
}
