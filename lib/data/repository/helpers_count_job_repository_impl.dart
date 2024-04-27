import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/helpers_count_job.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/domain/repository/helpers_count_job_repository.dart';

class HelpersCountJobRepositoryImpl implements HelpersCountJobRepository {
  HelpersCountJobRepositoryImpl(this._helperApiService);

  final HelperApiService _helperApiService;

  @override
  Future<DataState<CountJobModel>> getJobCount(
    String token,
    String jobStatus,
  ) async {
    try {
      final httpResponse = await _helperApiService.getJobCount(
        jobStatus: jobStatus,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(CountJobModel.fromJson(response.data!));
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
