import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetClosedJobUseCase
    implements UseCase<DataState<List<JobModelWithHelperInfo>>, String> {
  GetClosedJobUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<List<JobModelWithHelperInfo>>> call(String token) {
    return _neighborJobRepository.getClosedJobs(token);
  }
}
