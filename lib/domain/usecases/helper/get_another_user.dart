import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/another_user_model.dart';
import 'package:neighbour_app/domain/repository/helper_repository.dart';

class GetAnotherUserParams {
  GetAnotherUserParams({
    required this.token,
    required this.helperId,
  });

  final String token;
  final String helperId;
}

class GetAnotherUserUseCase
    implements UseCase<DataState<AnotherUserModel>, GetAnotherUserParams> {
  GetAnotherUserUseCase(this._helperRespository);

  final HelperRepository _helperRespository;

  @override
  Future<DataState<AnotherUserModel>> call(GetAnotherUserParams params) {
    return _helperRespository.getAnotherUser(
      token: params.token,
      helperId: params.helperId,
    );
  }
}
