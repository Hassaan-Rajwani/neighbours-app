import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/neighbor_bids_repository.dart';

class NeighborBidAcceptBody {
  NeighborBidAcceptBody({
    required this.token,
    required this.jobId,
    required this.bidId,
  });

  final String token;
  final String jobId;
  final String bidId;
}

class NeighborBidAcceptUseCase
    implements UseCase<DataState<String?>, NeighborBidAcceptBody> {
  NeighborBidAcceptUseCase(this._neighborBidsRepository);

  final NeighborBidsRepository _neighborBidsRepository;

  @override
  Future<DataState<String?>> call(NeighborBidAcceptBody body) {
    return _neighborBidsRepository.neighborBidAccept(
      bidId: body.bidId,
      jobId: body.jobId,
      token: body.token,
    );
  }
}
