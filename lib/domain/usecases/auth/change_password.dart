import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class ChangePasswordParams {
  ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });

  String oldPassword;
  String newPassword;
}

class ChangePasswordUseCase implements UseCase<String?, ChangePasswordParams> {
  ChangePasswordUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(ChangePasswordParams parms) {
    return _authenticationRepository.changePassword(
      oldPassword: parms.oldPassword,
      newPassword: parms.newPassword,
    );
  }
}
