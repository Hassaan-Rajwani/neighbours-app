import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/user_repository.dart';

class EditProfileParms {
  EditProfileParms({
    required this.body,
    required this.token,
  });

  String token;
  Map<String, dynamic> body;
}

class EditProfileUseCase
    implements UseCase<DataState<String?>, EditProfileParms> {
  EditProfileUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<String?>> call(EditProfileParms parms) {
    return _userRepository.editProfile(
      body: parms.body,
      token: parms.token,
    );
  }
}
