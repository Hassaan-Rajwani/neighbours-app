// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';

abstract class HelpersJobRepository {
  Future<DataState<HelpersPendingJobModel>> getJob(String token, String jobId);
  Future<DataState<List<HelpersPendingJobModel>>> getAllPendingJobs(
    String token,
    String status,
  );

  Future<DataState<List<HelperActiveJobModel>>> getAllActiveJobs({
    required String token,
    required String status,
    required int rating,
    required String size,
    required String order,
    required String pickupType,
    required double distance,
  });

  Future<DataState<List<HelperActiveJobModel>>> getAllClosedJobs(
    String token,
    String status,
  );

  Future<DataState<HelperJobModel>> getHelperJobById(
    String token,
    String jobId,
    String name,
  );
}
