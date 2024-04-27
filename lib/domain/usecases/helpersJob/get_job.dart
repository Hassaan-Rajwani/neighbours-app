import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class GetJobParams {
  GetJobParams({
    required this.token,
    required this.jobId,
  });

  final String token;
  final String jobId;
}

class GetJobUseCase
    implements UseCase<DataState<HelpersPendingJobModel>, GetJobParams> {
  GetJobUseCase(this._helpersJobRepository);

  final HelpersJobRepository _helpersJobRepository;

  @override
  Future<DataState<HelpersPendingJobModel>> call(GetJobParams params) {
    return _helpersJobRepository.getJob(params.jobId, params.token);
  }
}
