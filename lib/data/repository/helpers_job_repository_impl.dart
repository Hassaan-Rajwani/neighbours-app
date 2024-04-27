import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/data/models/helpers_pending_job.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';

class HelpersJobRepositoryImpl implements HelpersJobRepository {
  HelpersJobRepositoryImpl(this._helperApiService, this._neighborApiService);

  final HelperApiService _helperApiService;
  final NeighborApiService _neighborApiService;

  @override
  Future<DataState<HelpersPendingJobModel>> getJob(
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _helperApiService.getJob(
        jobId: jobId,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(HelpersPendingJobModel.fromJson(response.data!));
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
  Future<DataState<HelperJobModel>> getHelperJobById(
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
          return DataSuccess(HelperJobModel.fromJson(response.data!));
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
  Future<DataState<List<HelpersPendingJobModel>>> getAllPendingJobs(
    String token,
    String status,
  ) async {
    try {
      final httpResponse = await _helperApiService.getAllJobs(
        authToken: 'Bearer $token',
        status: status,
        pickupType: '',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final allJobs = <HelpersPendingJobModel>[];
          for (var i = 0; i < list.length; i++) {
            allJobs.add(HelpersPendingJobModel.fromJson(list[i]));
          }
          return DataSuccess(allJobs);
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
  Future<DataState<List<HelperActiveJobModel>>> getAllActiveJobs({
    required String token,
    required String status,
    required int rating,
    required String size,
    required String order,
    required String pickupType,
    required double distance,
  }) async {
    try {
      final httpResponse = await _helperApiService.getAllJobs(
        authToken: 'Bearer $token',
        status: status,
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
          final allJobs = <HelperActiveJobModel>[];
          for (var i = 0; i < list.length; i++) {
            allJobs.add(HelperActiveJobModel.fromJson(list[i]));
          }
          return DataSuccess(allJobs);
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
  Future<DataState<List<HelperActiveJobModel>>> getAllClosedJobs(
    String token,
    String status,
  ) async {
    try {
      final httpResponse = await _helperApiService.getAllJobs(
        authToken: 'Bearer $token',
        status: status,
        pickupType: '',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final allJobs = <HelperActiveJobModel>[];
          for (var i = 0; i < list.length; i++) {
            allJobs.add(HelperActiveJobModel.fromJson(list[i]));
          }
          return DataSuccess(allJobs);
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
