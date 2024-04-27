import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class LogoutParms {
  LogoutParms();
}

class LogoutUseCase implements UseCase<bool, LogoutParms> {
  LogoutUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<bool> call(LogoutParms parms) {
    return _authenticationRepository.logout();
  }
}
