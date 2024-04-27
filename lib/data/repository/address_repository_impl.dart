import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';
import 'package:neighbour_app/utils/storage.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl(this._neighborsApiService);

  final NeighborApiService _neighborsApiService;

  @override
  Future<DataState<String?>> createAddress({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.postAddAddress(
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
  Future<DataState<String?>> editAddress({
    required Map<String, dynamic> body,
    required String token,
    required String addressId,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.putEditAddress(
        authToken: 'Bearer $token',
        body: body,
        id: addressId,
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
  Future<DataState<String?>> deleteAddress({
    required String id,
  }) async {
    try {
      final token = await getDataFromStorage(StorageKeys.userToken);
      final httpResponse = await _neighborsApiService.deleteAddress(
        authToken: 'Bearer $token',
        id: id,
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
  Future<DataState<String?>> activeAddress({
    required String id,
    required String token,
  }) async {
    try {
      final httpResponse = await _neighborsApiService.putSetAddress(
        authToken: 'Bearer $token',
        id: id,
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
  Future<DataState<List<AddressModel>>> getAddressList(String token) async {
    try {
      final httpResponse = await _neighborsApiService.getUserAddress(
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final addresses = <AddressModel>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            addresses.add(AddressModel.fromJson(list[i]));
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
}
