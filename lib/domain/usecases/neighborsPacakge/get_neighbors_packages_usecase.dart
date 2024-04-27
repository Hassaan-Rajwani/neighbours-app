import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/domain/repository/neighbor_package_repository.dart';

class GetNeighborsPackageParms {
  GetNeighborsPackageParms({
    required this.jobId,
    required this.token,
  });

  String jobId;
  String token;
}

class GetNeighborPackageUseCase
    implements
        UseCase<DataState<List<NeighborsPackageModel>>,
            GetNeighborsPackageParms> {
  GetNeighborPackageUseCase(this._neighborsPackageRepository);

  final NeighborPackageRepository _neighborsPackageRepository;

  @override
  Future<DataState<List<NeighborsPackageModel>>> call(
    GetNeighborsPackageParms parms,
  ) {
    return _neighborsPackageRepository.getNeighborsPacakge(
      parms.token,
      parms.jobId,
    );
  }
}
