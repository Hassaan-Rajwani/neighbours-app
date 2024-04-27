import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/dispute_repository.dart';

class CreateDisputeParams {
  CreateDisputeParams({
    required this.body,
    required this.token,
    required this.jobId,
  });

  Map<String, dynamic> body;
  String token;
  String jobId;
}

class CreateDisputeUseCase
    implements UseCase<DataState<String?>, CreateDisputeParams> {
  CreateDisputeUseCase(this._disputeRepository);

  final DisputeRepository _disputeRepository;

  @override
  Future<DataState<String?>> call(CreateDisputeParams parms) {
    return _disputeRepository.createDispute(
      body: parms.body,
      token: parms.token,
      jobId: parms.jobId,
    );
  }
}
