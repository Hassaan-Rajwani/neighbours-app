import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';
import 'package:neighbour_app/domain/repository/helper_repository.dart';

class GetHelpersBody {
  GetHelpersBody({
    required this.rating,
    required this.miles,
    required this.token,
  });

  int rating;
  int miles;
  String token;
}

class GetAllHelperUseCase
    implements UseCase<DataState<List<AllHelpersModel>>, GetHelpersBody> {
  GetAllHelperUseCase(this._helperRespository);

  final HelperRepository _helperRespository;

  @override
  Future<DataState<List<AllHelpersModel>>> call(GetHelpersBody params) {
    return _helperRespository.getHelpersList(
      miles: params.miles,
      rating: params.rating,
      token: params.token,
    );
  }
}
