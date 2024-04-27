import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/sources/disputeApis/dispute_api.dart';
import 'package:neighbour_app/domain/repository/dispute_repository.dart';

class DisputeRepositoryImpl implements DisputeRepository {
  DisputeRepositoryImpl(this._disputeApiService);

  final DisputeApiService _disputeApiService;

  @override
  Future<DataState<String?>> createDispute({
    required Map<String, dynamic> body,
    required String token,
    required String jobId,
  }) async {
    try {
      final httpResponse = await _disputeApiService.postCreateDispute(
        authToken: 'Bearer $token',
        body: body,
        jobid: jobId,
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
