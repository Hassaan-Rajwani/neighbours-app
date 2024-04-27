// ignore_for_file: body_might_complete_normally_nullable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/data/models/favorite.dart';
import 'package:neighbour_app/domain/usecases/favorites/add_favorite.dart';
import 'package:neighbour_app/domain/usecases/favorites/delete_favorite.dart';
import 'package:neighbour_app/domain/usecases/favorites/get_favorites.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(
    this._getFavoriteUseCase,
    this._addFavoriteUseCase,
    this._deleteFavoriteUsecase,
  ) : super(FavoriteInitial()) {
    on<GetFavoriteListEvent>(_getFavoriteList);
    on<AddFavoriteEvent>(_addFavorite);
    on<DeleteFavoriteEvent>(_deleteFavorite);
  }

  final GetFavoritesUseCase _getFavoriteUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final DeleteFavoriteUseCase _deleteFavoriteUsecase;

  Future<void> _getFavoriteList(
    GetFavoriteListEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(GetFavoriteListInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getFavoriteUseCase(token);
      if (dataState.data != null) {
        emit(FavoriteListSuccessFull(list: dataState.data!));
      } else {
        emit(FavoriteListError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _addFavorite(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final params = AddFavoriteBody(
      favorite: event.body,
      token: event.token,
    );
    final dataState = await _addFavoriteUseCase(params);
    if (dataState.data == null) {
      sl<FavoriteBloc>().add(GetFavoriteListEvent());
      emit(AddFavoriteSuccessfull());
    } else {
      emit(AddFavoriteError(error: dataState.error!.message!));
    }
  }

  Future<Map<String, dynamic>?> _deleteFavorite(
    DeleteFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = DeleteFavoriteBody(
        favoriteID: event.favoriteID,
        token: token,
      );
      await _deleteFavoriteUsecase(params);
    }
  }
}
