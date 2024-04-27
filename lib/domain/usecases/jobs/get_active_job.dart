import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class GetActiveBody {
  GetActiveBody({
    required this.token,
    required this.rating,
    required this.size,
    required this.order,
    required this.pickupType,
    required this.distance,
  });

  int rating;
  String size;
  String order;
  String pickupType;
  double distance;
  String token;
}

class GetAtiveJobUseCase
    implements UseCase<DataState<List<JobModelWithHelperInfo>>, GetActiveBody> {
  GetAtiveJobUseCase(this._neighborJobRepository);

  final NeighborJobRepository _neighborJobRepository;

  @override
  Future<DataState<List<JobModelWithHelperInfo>>> call(GetActiveBody params) {
    return _neighborJobRepository.getActiveJobs(
      token: params.token,
      rating: params.rating,
      size: params.size,
      order: params.order,
      pickupType: params.pickupType,
      distance: params.distance,
    );
  }
}
