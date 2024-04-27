import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/domain/repository/helpers_package_repository.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/helperPackage/helper_package_bloc.dart';

class HelpersPackageRepositoryImpl implements HelpersPackageRepository {
  HelpersPackageRepositoryImpl(this._helperApiService);

  final HelperApiService _helperApiService;

  @override
  Future<DataState<String?>> createPackage(
    Map<String, dynamic> body,
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _helperApiService.postCreatePackage(
        jobId: jobId,
        authToken: 'Bearer $token',
        body: body,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        sl<HelperPackageBloc>().add(
          GetPackageEvent(
            jobId: jobId,
          ),
        );
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
  Future<DataState<List<NeighborsPackageModel>>> getPackage(
    String token,
    String jobId,
  ) async {
    try {
      final httpResponse = await _helperApiService.getPackage(
        jobId: jobId,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final activeJobs = <NeighborsPackageModel>[];
          for (var i = 0; i < list.length; i++) {
            activeJobs.add(NeighborsPackageModel.fromJson(list[i]));
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
}
