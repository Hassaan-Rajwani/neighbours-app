import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/domain/repository/helpers_package_repository.dart';

class GetHelperPackageParams {
  GetHelperPackageParams({required this.token, required this.jobId});

  final String token;
  final String jobId;
}

class GetHelperPackageUseCase
    implements
        UseCase<DataState<List<NeighborsPackageModel>>,
            GetHelperPackageParams> {
  GetHelperPackageUseCase(this._helperPackageRepository);

  final HelpersPackageRepository _helperPackageRepository;

  @override
  Future<DataState<List<NeighborsPackageModel>>> call(
    GetHelperPackageParams params,
  ) {
    return _helperPackageRepository.getPackage(
      params.token,
      params.jobId,
    );
  }
}
