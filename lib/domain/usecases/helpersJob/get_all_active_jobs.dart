import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class GetAllActiveJobsBody {
  GetAllActiveJobsBody({
    required this.status,
    required this.token,
    required this.rating,
    required this.size,
    required this.order,
    required this.pickupType,
    required this.distance,
  });

  String status;
  String token;
  int rating;
  String size;
  String order;
  String pickupType;
  double distance;
}

class GetAllActiveJobsUseCase
    implements
        UseCase<DataState<List<HelperActiveJobModel>>, GetAllActiveJobsBody> {
  GetAllActiveJobsUseCase(this._helpersJobRepository);

  final HelpersJobRepository _helpersJobRepository;

  @override
  Future<DataState<List<HelperActiveJobModel>>> call(
    GetAllActiveJobsBody params,
  ) {
    return _helpersJobRepository.getAllActiveJobs(
      token: params.token,
      status: params.status,
      distance: params.distance,
      order: params.order,
      pickupType: params.pickupType,
      rating: params.rating,
      size: params.size,
    );
  }
}
