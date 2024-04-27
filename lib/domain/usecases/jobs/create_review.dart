import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class CreateReviewBody {
  CreateReviewBody({
    required this.token,
    required this.jobId,
    required this.reviewBody,
  });

  final String token;
  final String jobId;
  final Map<String, dynamic> reviewBody;
}

class CreateReviewUseCase
    implements UseCase<DataState<String?>, CreateReviewBody> {
  CreateReviewUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;
  @override
  Future<DataState<String?>> call(CreateReviewBody body) {
    return _neighborJobRepository.createReview(
      body.token,
      body.jobId,
      body.reviewBody,
    );
  }
}
