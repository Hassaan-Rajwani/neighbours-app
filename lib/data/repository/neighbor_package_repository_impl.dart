import 'dart:io';

import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/neighbor_package_repository.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/neighborsPackages/neighbors_packages_bloc.dart';

class NeighborPackageRepositoryImpl implements NeighborPackageRepository {
  NeighborPackageRepositoryImpl(this._neighborApiService);

  final NeighborApiService _neighborApiService;

  @override
  Future<DataState<List<NeighborsPackageModel>>> getNeighborsPacakge(
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _neighborApiService.getNeighborsPackages(
        authToken: 'Bearer $token',
        jobId: jobId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final addresses = <NeighborsPackageModel>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            addresses.add(NeighborsPackageModel.fromJson(list[i]));
          }
          return DataSuccess(addresses);
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
  Future<DataState<String?>> updateNeighborsPackage(
    String token,
    String jobId,
    String packageId,
  ) async {
    try {
      final httpResponse = await _neighborApiService.confirmPackage(
        authToken: 'Bearer $token',
        jobId: jobId,
        packageId: packageId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        sl<NeighborsPackagesBloc>().add(
          GetNeighborsPackage(
            jobId: jobId,
          ),
        );
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(
            response.data.toString(),
          );
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
  Future<DataState<String?>> giveTip(
    String token,
    Map<String, dynamic> tipBody,
  ) async {
    try {
      final httpResponse = await _neighborApiService.giveTip(
        authToken: 'Bearer $token',
        body: tipBody,
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
