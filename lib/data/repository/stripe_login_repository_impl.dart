// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/helper_stripe_model.dart';
import 'package:neighbour_app/data/sources/stripeApi/stripe_api.dart';
import 'package:neighbour_app/domain/repository/stripe_login_repository.dart';

class StripeRepositoryImpl implements StripeRepository {
  StripeRepositoryImpl(this._stripeApiService);

  final StripeApiService _stripeApiService;

  @override
  Future<DataState<HelperStripeModel>> addCard({required String token}) async {
    try {
      final httpResponse = await _stripeApiService.accountLogin(
        authToken: 'Bearer $token',
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          // HelperStripeModel helperStripeModel =
          //     HelperStripeModel.fromJson(response.data!);
          // String url = helperStripeModel.loginUrl;
          return DataSuccess(HelperStripeModel.fromJson(response.data!));
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
