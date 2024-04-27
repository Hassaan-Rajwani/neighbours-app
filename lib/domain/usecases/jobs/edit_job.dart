import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class EditJobBody {
  EditJobBody({
    required this.body,
    required this.token,
    required this.jobId,
  });

  Map<String, dynamic> body;
  String token;
  String jobId;
}

class EditJobUseCase implements UseCase<DataState<String?>, EditJobBody> {
  EditJobUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<String?>> call(EditJobBody parms) {
    return _neighborJobRepository.editJob(
      body: parms.body,
      token: parms.token,
      jobId: parms.jobId,
    );
  }
}
