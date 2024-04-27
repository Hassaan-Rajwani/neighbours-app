import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/helpers_bid_repository.dart';

class RejectBidBody {
  RejectBidBody({
    required this.token,
    required this.jobId,
  });

  final String token;
  final String jobId;
}

class RejectBidUseCase implements UseCase<String?, RejectBidBody> {
  RejectBidUseCase(this._helpersBidRepository);

  final HelpersBidRepository _helpersBidRepository;

  @override
  Future<String?> call(RejectBidBody body) {
    return _helpersBidRepository.rejectJob(
      body.token,
      body.jobId,
    );
  }
}
