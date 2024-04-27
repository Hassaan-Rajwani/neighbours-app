// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/sources/cancelApis/cancel_job_api.dart';
import 'package:neighbour_app/domain/repository/cancel_job_repository.dart';

class CancelJobRepositoryImpl implements CancelJobRepository {
  CancelJobRepositoryImpl(this._cancelJobApiService);

  final CancelJobApiService _cancelJobApiService;

  @override
  Future<DataState<String?>> postCancelJob({
    required String token,
    required String jobId,
    required Map<String, dynamic> body,
  }) async {
    try {
      final httpResponse = await _cancelJobApiService.postCancelJob(
        authToken: 'Bearer $token',
        jobid: jobId,
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
}
