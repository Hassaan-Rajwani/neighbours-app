import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class CreateCancelReviewBody {
  CreateCancelReviewBody({
    required this.token,
    required this.jobId,
    required this.reviewBody,
    required this.isNeighbor,
  });

  final String token;
  final String jobId;
  final bool isNeighbor;
  final Map<String, dynamic> reviewBody;
}

class CreateCancelReviewUseCase
    implements UseCase<DataState<String?>, CreateCancelReviewBody> {
  CreateCancelReviewUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;
  @override
  Future<DataState<String?>> call(CreateCancelReviewBody body) {
    return _neighborJobRepository.createCancelReview(
      body.token,
      body.jobId,
      body.reviewBody,
      body.isNeighbor,
    );
  }
}
