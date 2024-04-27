import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class GetHelperJobByIdParams {
  GetHelperJobByIdParams({
    required this.token,
    required this.jobId,
    required this.name,
  });

  final String token;
  final String jobId;
  final String name;
}

class GetHelperJobByIdUseCase
    implements UseCase<DataState<HelperJobModel>, GetHelperJobByIdParams> {
  GetHelperJobByIdUseCase(this._helperJobsRepository);

  final HelpersJobRepository _helperJobsRepository;

  @override
  Future<DataState<HelperJobModel>> call(GetHelperJobByIdParams params) {
    return _helperJobsRepository.getHelperJobById(
      params.token,
      params.jobId,
      params.name,
    );
  }
}
