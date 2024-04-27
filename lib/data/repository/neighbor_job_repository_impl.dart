import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/data/models/job_history.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/data/models/jobs_model.dart';
import 'package:neighbour_app/data/models/reviews.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';

class NeighborJobRepositoryImpl implements NeighborJobRepository {
  NeighborJobRepositoryImpl(this._neighborApiService);

  final NeighborApiService _neighborApiService;

  @override
  Future<DataState<List<JobModelWithHelperInfo>>> getActiveJobs({
    required String token,
    required int rating,
    required String size,
    required String order,
    required String pickupType,
    required double distance,
  }) async {
    try {
      final httpResponse = await _neighborApiService.getActiveJobs(
        authToken: 'Bearer $token',
        distance: distance,
        order: order,
        pickupType: pickupType,
        rating: rating,
        size: size,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final activeJobs = <JobModelWithHelperInfo>[];
          for (var i = 0; i < list.length; i++) {
            activeJobs.add(JobModelWithHelperInfo.fromJson(list[i]));
          }
          return DataSuccess(activeJobs);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<JobHistoryModel>>> getJobHistory({
    required String token,
    required String userId,
    required bool isNeighbr,
  }) async {
    try {
      final httpResponse = await _neighborApiService.getJobHistory(
          id: userId, authToken: 'Bearer $token', isNeighbr: isNeighbr,);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final activeJobs = <JobHistoryModel>[];
          for (var i = 0; i < list.length; i++) {
            activeJobs.add(JobHistoryModel.fromJson(list[i]));
          }
          return DataSuccess(activeJobs);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ReviewsModel>>> getReviews({
    required String token,
    required String userId,
    required bool isNeighbr,
  }) async {
    try {
      final httpResponse = await _neighborApiService.getUserReviews(
        id: userId,
        authToken: 'Bearer $token',
        isNeighbr: isNeighbr,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final reviewList = <ReviewsModel>[];
          for (var i = 0; i < list.length; i++) {
            reviewList.add(ReviewsModel.fromJson(list[i]));
          }
          return DataSuccess(reviewList);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<JobModel>>> getPendingJobs(String token) async {
    try {
      final httpResponse = await _neighborApiService.getPendingJobs(
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final pendingJob = <JobModel>[];
          for (var i = 0; i < list.length; i++) {
            pendingJob.add(JobModel.fromJson(list[i]));
          }
          return DataSuccess(pendingJob);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<JobModelWithHelperInfo>>> getClosedJobs(
    String token,
  ) async {
    try {
      final httpResponse = await _neighborApiService.getClosedJobs(
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final colsedJob = <JobModelWithHelperInfo>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            colsedJob.add(JobModelWithHelperInfo.fromJson(list[i]));
          }
          return DataSuccess(colsedJob);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<JobByIdModel>> getJobById(
    String token,
    String jobId,
    String name,
  ) async {
    try {
      final httpResponse = await _neighborApiService.getJobById(
        name: name,
        jobId: jobId,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(JobByIdModel.fromJson(response.data!));
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> createJob({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      final httpResponse = await _neighborApiService.postCreateJob(
        authToken: 'Bearer $token',
        body: body,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<JobModel>> postCloseJob(String token, String jobId) async {
    try {
      final httpResponse = await _neighborApiService.postClosedJob(
        authToken: 'Bearer $token',
        jobId: jobId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(JobModel.fromJson(response.data!));
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> createReview(
    String token,
    String jobId,
    Map<String, dynamic> reviewBody,
  ) async {
    try {
      final httpResponse = await _neighborApiService.postCreateReview(
        authToken: 'Bearer $token',
        body: reviewBody,
        jobId: jobId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> editJob({
    required Map<String, dynamic> body,
    required String token,
    required String jobId,
  }) async {
    try {
      final httpResponse = await _neighborApiService.editJob(
        authToken: 'Bearer $token',
        body: body,
        jobId: jobId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
        }
      }

      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> createCancelReview(
    String token,
    String jobId,
    Map<String, dynamic> reviewBody,
    bool isNeighbor,
  ) async {
    try {
      final httpResponse = await _neighborApiService.cancelReview(
        authToken: 'Bearer $token',
        body: reviewBody,
        jobId: jobId,
        isNeighbr: isNeighbor,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
