import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';

class PostFcmParms {
  PostFcmParms({
    required this.body,
    required this.token,
  });

  Map<String, dynamic> body;
  String token;
}

class PostFcmUseCase implements UseCase<DataState<String?>, PostFcmParms> {
  PostFcmUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<DataState<String?>> call(PostFcmParms parms) {
    return _authenticationRepository.postFcm(
      token: parms.token,
      body: parms.body,
    );
  }
}
