import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class SignInParams {
  SignInParams({required this.email, required this.password});

  String email;
  String password;
}

class SignInUseCase implements UseCase<String?, SignInParams> {
  SignInUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(SignInParams parms) {
    return _authenticationRepository.signIn(
      email: parms.email,
      password: parms.password,
    );
  }
}
