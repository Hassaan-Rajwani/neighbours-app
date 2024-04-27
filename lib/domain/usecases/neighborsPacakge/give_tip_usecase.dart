import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/neighbor_package_repository.dart';

class TipBody {
  TipBody({
    required this.token,
    required this.tipBody,
  });

  final String token;
  final Map<String, dynamic> tipBody;
}

class GiveTipUseCase implements UseCase<DataState<String?>, TipBody> {
  GiveTipUseCase(this._neighborPackageRepository);

  final NeighborPackageRepository _neighborPackageRepository;
  @override
  Future<DataState<String?>> call(TipBody body) {
    return _neighborPackageRepository.giveTip(
      body.token,
      body.tipBody,
    );
  }
}
