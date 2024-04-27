import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/jobs_model.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetPendingJobUseCase
    implements UseCase<DataState<List<JobModel>>, String> {
  GetPendingJobUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<List<JobModel>>> call(String token) {
    return _neighborJobRepository.getPendingJobs(token);
  }
}
