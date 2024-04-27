import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class SignUpParams {
  SignUpParams({
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

class SignUpUseCase implements UseCase<String?, SignUpParams> {
  SignUpUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<String?> call(SignUpParams params) {
    return _authenticationRepository.signUp(
      email: params.email,
      password: params.password,
      lastName: params.lastName,
      firstName: params.firstName,
    );
  }
}
