import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/job_history.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetJobHistoryParams {
  GetJobHistoryParams({
    required this.token,
    required this.userId,
    required this.isNeighbr,
  });

  final String token;
  final String userId;
  final bool isNeighbr;
}

class GetJobHistoryUseCase
    implements UseCase<DataState<List<JobHistoryModel>>, GetJobHistoryParams> {
  GetJobHistoryUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<List<JobHistoryModel>>> call(GetJobHistoryParams params) {
    return _neighborJobRepository.getJobHistory(
      token: params.token,
      userId: params.userId,
      isNeighbr: params.isNeighbr,
    );
  }
}
