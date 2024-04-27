import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/neighbor_bids_repository.dart';

class NeighborBidRejectBody {
  NeighborBidRejectBody({
    required this.token,
    required this.jobId,
    required this.bidId,
  });

  final String token;
  final String jobId;
  final String bidId;
}

class NeighborBidRejectCase
    implements UseCase<DataState<String?>, NeighborBidRejectBody> {
  NeighborBidRejectCase(this._neighborBidsRepository);

  final NeighborBidsRepository _neighborBidsRepository;

  @override
  Future<DataState<String?>> call(NeighborBidRejectBody body) {
    return _neighborBidsRepository.putRejectBid(
      token: body.token,
      jobId: body.jobId,
      bidId: body.bidId,
    );
  }
}
