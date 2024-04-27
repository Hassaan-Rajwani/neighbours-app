import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/user_repository.dart';

class DeleteProfileUseCase implements UseCase<DataState<String?>, String> {
  DeleteProfileUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<String?>> call(String token) {
    return _userRepository.deleteAccount(token);
  }
}
