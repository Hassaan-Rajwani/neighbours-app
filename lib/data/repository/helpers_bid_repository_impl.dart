import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/domain/repository/helpers_bid_repository.dart';

class HelpersBidRepositoryImpl implements HelpersBidRepository {
  HelpersBidRepositoryImpl(this._helperApiService);

  final HelperApiService _helperApiService;

  @override
  Future<String?> postCreateBid(
    String token,
    Map<String, dynamic> body,
    String bidId,
  ) async {
    try {
      final httpResponse = await _helperApiService.postCreateBid(
        bidId: bidId,
        authToken: 'Bearer $token',
        body: body,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return null;
        }
      }
    } catch (e) {
      return '$e';
    }
    return null;
  }

  @override
  Future<String?> rejectJob(
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _helperApiService.postRejectJob(
        authToken: 'Bearer $token',
        rejectId: jobId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return null;
        }
      }
    } on DioException catch (e) {
      return '$e';
    }
    return null;
  }
}
