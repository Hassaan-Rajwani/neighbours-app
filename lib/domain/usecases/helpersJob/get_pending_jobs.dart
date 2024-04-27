import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class GetAllPendingJobsBody {
  GetAllPendingJobsBody({
    required this.status,
    required this.token,
  });

  String status;
  String token;
}

class GetAllPendingJobsUseCase
    implements
        UseCase<DataState<List<HelpersPendingJobModel>>,
            GetAllPendingJobsBody> {
  GetAllPendingJobsUseCase(this._helpersJobRepository);

  final HelpersJobRepository _helpersJobRepository;

  @override
  Future<DataState<List<HelpersPendingJobModel>>> call(
      GetAllPendingJobsBody params,) {
    return _helpersJobRepository.getAllPendingJobs(
      params.token,
      params.status,
    );
  }
}
