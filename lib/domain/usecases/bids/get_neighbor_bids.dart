import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/bids.dart';
import 'package:neighbour_app/domain/repository/neighbor_bids_repository.dart';

class GetNeighborBidsBody {
  GetNeighborBidsBody({required this.token, required this.jobId});

  final String token;
  final String jobId;
}

class GetNeighborBidsUseCase
    implements UseCase<DataState<List<BidsModel>>, GetNeighborBidsBody> {
  GetNeighborBidsUseCase(this._neighborBidsRepository);

  final NeighborBidsRepository _neighborBidsRepository;

  @override
  Future<DataState<List<BidsModel>>> call(GetNeighborBidsBody body) {
    return _neighborBidsRepository.getNeighborBids(body.token, body.jobId);
  }
}
