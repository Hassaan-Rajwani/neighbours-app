import 'dart:io';

import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/another_user_model.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/data/sources/userApis/user_api.dart';
import 'package:neighbour_app/domain/repository/helper_repository.dart';

class HelperRespositoryImpl implements HelperRepository {
  HelperRespositoryImpl(this._helperApiService, this._userApiService);

  final HelperApiService _helperApiService;
  final UserApiService _userApiService;

  @override
  Future<DataState<List<AllHelpersModel>>> getHelpersList({
    required String token,
    required int rating,
    required int miles,
  }) async {
    try {
      final httpResponse = await _helperApiService.getAllHelper(
        miles: miles,
        authToken: 'Bearer $token',
        rating: rating,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final addresses = <AllHelpersModel>[];
          final list = response.data!;
          for (var i = 0; i < list.length; i++) {
            addresses.add(AllHelpersModel.fromJson(list[i]));
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
  Future<DataState<AnotherUserModel>> getAnotherUser({
    required String token,
    required String helperId,
  }) async {
    try {
      final httpResponse = await _userApiService.getOtherProfile(
        id: helperId,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(AnotherUserModel.fromJson(response.data!));
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
