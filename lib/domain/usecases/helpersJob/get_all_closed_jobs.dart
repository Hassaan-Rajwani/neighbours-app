import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class GetAllClosedJobsBody {
  GetAllClosedJobsBody({
    required this.status,
    required this.token,
  });

  String status;
  String token;
}

class GetAllClosedJobsUseCase
    implements
        UseCase<DataState<List<HelperActiveJobModel>>, GetAllClosedJobsBody> {
  GetAllClosedJobsUseCase(this._helpersJobRepository);

  final HelpersJobRepository _helpersJobRepository;

  @override
  Future<DataState<List<HelperActiveJobModel>>> call(
    GetAllClosedJobsBody params,
  ) {
    return _helpersJobRepository.getAllClosedJobs(
      params.token,
      params.status,
    );
  }
}
