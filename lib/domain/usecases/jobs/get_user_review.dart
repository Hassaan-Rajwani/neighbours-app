import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/reviews.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetReviewParams {
  GetReviewParams({
    required this.token,
    required this.userId,
    required this.isNeighbr,
  });

  final String token;
  final String userId;
  final bool isNeighbr;
}

class GetReviewUseCase
    implements UseCase<DataState<List<ReviewsModel>>, GetReviewParams> {
  GetReviewUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<List<ReviewsModel>>> call(GetReviewParams params) {
    return _neighborJobRepository.getReviews(
      token: params.token,
      userId: params.userId,
      isNeighbr: params.isNeighbr,
    );
  }
}
