import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/neighbor_package_repository.dart';

class UpdateNeighborsPackageParms {
  UpdateNeighborsPackageParms({
    required this.token,
    required this.jobId,
    required this.packageId,
  });

  String token;
  String jobId;
  String packageId;
}

class UpdateNeighborPackageUseCase
    implements UseCase<DataState<String?>, UpdateNeighborsPackageParms> {
  UpdateNeighborPackageUseCase(this._neighborsPackageRepository);

  final NeighborPackageRepository _neighborsPackageRepository;

  @override
  Future<DataState<String?>> call(
    UpdateNeighborsPackageParms parms,
  ) {
    return _neighborsPackageRepository.updateNeighborsPackage(
      parms.token,
      parms.jobId,
      parms.packageId,
    );
  }
}
