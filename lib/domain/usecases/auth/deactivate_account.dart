import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class DeactivateAccount {
  DeactivateAccount({
    required this.body,
    required this.token,
  });

  Map<String, dynamic> body;
  String token;
}

class DeactivateUseCase
    implements UseCase<DataState<String?>, DeactivateAccount> {
  DeactivateUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<DataState<String?>> call(DeactivateAccount parms) {
    return _authenticationRepository.deleteAccount(
      token: parms.token,
      body: parms.body,
    );
  }
}
