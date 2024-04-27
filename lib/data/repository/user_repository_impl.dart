import 'dart:io';

import 'package:dio/dio.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/user.dart';
import 'package:neighbour_app/data/sources/userApis/user_api.dart';
import 'package:neighbour_app/domain/repository/user_repository.dart';
import 'package:neighbour_app/utils/storage.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userApiService);

  final UserApiService _userApiService;

  @override
  Future<DataState<UserModel>> getProfile(String token) async {
    try {
      final httpResponse = await _userApiService.getProfile(
        authToken: 'Bearer $token',
      );

      final response = APIResponseMap.fromJson(httpResponse.data);
      if (response.data != null) {
        await setDataToStorage(
          StorageKeys.userId,
          response.data!['_id'].toString(),
        );
        return DataSuccess(UserModel.fromJson(response.data!));
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
  Future<DataState<String?>> deleteAccount(String token) async {
    try {
      final httpResponse = await _userApiService.deleteAccount(
        authToken: 'Bearer $token',
      );

      final response = APIResponseMap.fromJson(httpResponse.data);
      if (response.data != null) {
        return const DataSuccess(null);
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
  Future<DataState<String?>> editProfile({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    try {
      final httpResponse = await _userApiService.updateProfile(
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
}
