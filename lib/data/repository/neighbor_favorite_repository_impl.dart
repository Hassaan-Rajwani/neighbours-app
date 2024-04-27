import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_list.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/data/models/favorite.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/domain/repository/neighbor_favorite_repository.dart';

class NeighborFavoriteRepositoryImpl implements NeighborFavoriteRepository {
  NeighborFavoriteRepositoryImpl(this._neighborApiService);

  final NeighborApiService _neighborApiService;

  @override
  Future<DataState<List<FavoriteModel>>> getFavoriteList(String token) async {
    try {
      final httpResponse = await _neighborApiService.getFavouriteList(
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseList.fromJson(httpResponse.data);
        if (response.data != null) {
          final list = response.data!;
          final favorite = <FavoriteModel>[];
          for (var i = 0; i < list.length; i++) {
            favorite.add(FavoriteModel.fromJson(list[i]));
          }
          return DataSuccess(favorite);
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
  Future<DataState<String?>> addFavorite(
    String token,
    AddFavorite favorite,
  ) async {
    try {
      final httpResponse = await _neighborApiService.postFavourite(
        authToken: 'Bearer $token',
        body: favorite.toJson(),
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
  Future<DataState<String?>> deleteFavorite(String token, String id) async {
    try {
      final httpResponse = await _neighborApiService.deleteFavouriteUser(
        id: id,
        authToken: 'Bearer $token',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data!['acknowledged'] == true) {
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
