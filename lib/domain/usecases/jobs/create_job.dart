import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class CreateJobBody {
  CreateJobBody({
    required this.body,
    required this.token,
  });

  Map<String, dynamic> body;
  String token;
}

class CreateJobUseCase implements UseCase<DataState<String?>, CreateJobBody> {
  CreateJobUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<String?>> call(CreateJobBody parms) {
    return _neighborJobRepository.createJob(
      body: parms.body,
      token: parms.token,
    );
  }
}
