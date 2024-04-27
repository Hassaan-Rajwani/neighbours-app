import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/helpers_bid_repository.dart';

class CreateBidBody {
  CreateBidBody({
    required this.token,
    required this.body,
    required this.bidId,
  });

  final String token;
  final Map<String, dynamic> body;
  final String bidId;
}

class CreateBidUseCase implements UseCase<String?, CreateBidBody> {
  CreateBidUseCase(this._helpersBidRepository);

  final HelpersBidRepository _helpersBidRepository;

  @override
  Future<String?> call(CreateBidBody body) {
    return _helpersBidRepository.postCreateBid(
      body.token,
      body.body,
      body.bidId,
    );
  }
}
