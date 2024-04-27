import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/jobs_model.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class PostCloseJobBody {
  PostCloseJobBody({required this.token, required this.jobId});

  final String token;
  final String jobId;
}

class PostCloseJobUseCase
    implements UseCase<DataState<JobModel>, PostCloseJobBody> {
  PostCloseJobUseCase(this._userRepository);

  final NeighborJobRepository _userRepository;

  @override
  Future<DataState<JobModel>> call(PostCloseJobBody body) {
    return _userRepository.postCloseJob(body.token, body.jobId);
  }
}
