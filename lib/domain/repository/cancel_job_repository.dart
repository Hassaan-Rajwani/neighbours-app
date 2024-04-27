// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';

abstract class CancelJobRepository {
  Future<DataState<String?>> postCancelJob({
    required String token,
    required String jobId,
    required Map<String, dynamic> body,
  });
}
