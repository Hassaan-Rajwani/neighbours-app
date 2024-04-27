import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/data/models/favorite.dart';

class DeleteFavorite {
  DeleteFavorite({required this.acknowledge, required this.deletedCount});
  final bool acknowledge;
  final String deletedCount;
}

abstract class NeighborFavoriteRepository {
  Future<DataState<List<FavoriteModel>>> getFavoriteList(String token);

  Future<DataState<String?>> addFavorite(
    String token,
    AddFavorite favorite,
  );
  Future<DataState<String?>> deleteFavorite(String token, String id);
}
