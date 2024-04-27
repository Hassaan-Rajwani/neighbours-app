import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/models/card_model.dart';
import 'package:neighbour_app/data/models/payment_model.dart';
import 'package:neighbour_app/data/sources/cardApis/card_api.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';

class CardsRepositoryImpl implements CardRepository {
  CardsRepositoryImpl(this._cardApiService);

  final CardApiService _cardApiService;

  @override
  Future<DataState<List<CardModel>>> getCardList(String token) async {
    try {
      final httpResponse = await _cardApiService.getCards(
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        final addresses = <CardModel>[];
        final list = response.data!;
        for (var i = 0; i < list.length; i++) {
          addresses.add(CardModel.fromJson(list[i]));
        }
        return DataSuccess(addresses);
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
  Future<DataState<String?>> deleteCard({
    required String id,
    required String token,
  }) async {
    try {
      final httpResponse = await _cardApiService.deleteCard(
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
  Future<DataState<String?>> updateCard({
    required String id,
    required String token,
  }) async {
    try {
      final httpResponse = await _cardApiService.updateCard(
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
  Future<DataState<StripeModel>> addCard({required String token}) async {
    try {
      final httpResponse = await _cardApiService.addCard(
        authToken: 'Bearer $token',
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return DataSuccess(
            StripeModel.fromJson(response.data!),
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
}
