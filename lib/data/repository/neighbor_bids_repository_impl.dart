import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/bids.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/neighbor_bids_repository.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';

class NeighborBidsRepositoryImpl implements NeighborBidsRepository {
  NeighborBidsRepositoryImpl(this._neighborApiService);

  final NeighborApiService _neighborApiService;

  @override
  Future<DataState<List<BidsModel>>> getNeighborBids(
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _neighborApiService.getBid(
        jobId: jobId,
        authToken: 'Bearer $token',
      );

      final response = APIResponseList.fromJson(httpResponse.data);
      if (response.data != null) {
        final neighborBids = <BidsModel>[];
        for (var i = 0; i < response.data!.length; i++) {
          neighborBids.add(BidsModel.fromJson(response.data![i]));
        }
        return DataSuccess(neighborBids);
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
  Future<DataState<String?>> neighborBidAccept({
    required String token,
    required String jobId,
    required String bidId,
  }) async {
    try {
      final httpResponse = await _neighborApiService.postAcceptBid(
        authToken: 'Bearer $token',
        jobId: jobId,
        bidId: bidId,
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
  Future<DataState<String?>> putRejectBid({
    required String token,
    required String jobId,
    required String bidId,
  }) async {
    try {
      final httpResponse = await _neighborApiService.postRejectBid(
        authToken: 'Bearer $token',
        jobId: jobId,
        bidId: bidId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          sl<JobsBloc>().add(
            const GetPendingJobEvent(),
          );
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
