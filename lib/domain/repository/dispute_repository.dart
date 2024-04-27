// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';

abstract class DisputeRepository {
  Future<DataState<String?>> createDispute({
    required Map<String, dynamic> body,
    required String token,
    required String jobId,
  });
}
