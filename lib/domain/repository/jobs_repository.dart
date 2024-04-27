// ignore_for_file: avoid_positional_boolean_parameters

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/data/models/job_history.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/data/models/jobs_model.dart';
import 'package:neighbour_app/data/models/reviews.dart';

abstract class NeighborJobRepository {
  Future<DataState<List<JobModelWithHelperInfo>>> getActiveJobs({
    required String token,
    required int rating,
    required String size,
    required String order,
    required String pickupType,
    required double distance,
  });

  Future<DataState<List<JobModel>>> getPendingJobs(String token);

  Future<DataState<List<JobModelWithHelperInfo>>> getClosedJobs(String token);

  Future<DataState<JobByIdModel>> getJobById(
    String token,
    String jobId,
    String name,
  );

  Future<DataState<String?>> createJob({
    required Map<String, dynamic> body,
    required String token,
  });

  Future<DataState<String?>> editJob({
    required Map<String, dynamic> body,
    required String token,
    required String jobId,
  });

  Future<DataState<JobModel>> postCloseJob(String token, String jobId);

  Future<DataState<String?>> createReview(
    String token,
    String jobId,
    Map<String, dynamic> reviewBody,
  );

  Future<DataState<List<JobHistoryModel>>> getJobHistory({
    required String token,
    required String userId,
    required bool isNeighbr,
  });
  Future<DataState<String?>> createCancelReview(
    String token,
    String jobId,
    Map<String, dynamic> reviewBody,
    bool isNeighbor,
  );

  Future<DataState<List<ReviewsModel>>> getReviews({
    required String token,
    required String userId,
    required bool isNeighbr,
  });
}
