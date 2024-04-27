// ignore_for_file: file_names

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/cancel_job_repository.dart';

class PostCancelJobBody {
  PostCancelJobBody({
    required this.token,
    required this.jobId,
    required this.body,
  });

  final String token;
  final String jobId;
  final Map<String, dynamic> body;
}

class PostCancelJobUseCase
    implements UseCase<DataState<String?>, PostCancelJobBody> {
  PostCancelJobUseCase(this._cancelJobRepository);

  final CancelJobRepository _cancelJobRepository;

  @override
  Future<DataState<String?>> call(PostCancelJobBody parms) {
    return _cancelJobRepository.postCancelJob(
      token: parms.token,
      jobId: parms.jobId,
      body: parms.body,
    );
  }
}
