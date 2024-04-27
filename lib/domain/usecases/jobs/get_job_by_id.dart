import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetJobByIdParams {
  GetJobByIdParams({
    required this.token,
    required this.jobId,
    required this.name,
  });

  final String token;
  final String jobId;
  final String name;
}

class GetJobByIdUseCase
    implements UseCase<DataState<JobByIdModel>, GetJobByIdParams> {
  GetJobByIdUseCase(this._userRepository);

  final NeighborJobRepository _userRepository;

  @override
  Future<DataState<JobByIdModel>> call(GetJobByIdParams params) {
    return _userRepository.getJobById(
      params.token,
      params.jobId,
      params.name,
    );
  }
}
