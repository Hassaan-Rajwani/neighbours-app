import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/user.dart';
import 'package:neighbour_app/domain/repository/user_repository.dart';

class GetProfileUseCase implements UseCase<DataState<UserModel>, String> {
  GetProfileUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<UserModel>> call(String token) {
    return _userRepository.getProfile(token);
  }
}
