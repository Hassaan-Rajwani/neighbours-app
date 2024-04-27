import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class GoogleAuthParms {
  GoogleAuthParms();
}

class GoogleAuthUseCase implements UseCase<String?, GoogleAuthParms> {
  GoogleAuthUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(GoogleAuthParms parms) {
    return _authenticationRepository.googleSignin();
  }
}
