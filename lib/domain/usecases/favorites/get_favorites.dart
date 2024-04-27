import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/favorite.dart';
import 'package:neighbour_app/domain/repository/neighbor_favorite_repository.dart';

class GetFavoritesUseCase
    implements UseCase<DataState<List<FavoriteModel>>, String> {
  GetFavoritesUseCase(this._favoriteRepository);

  final NeighborFavoriteRepository _favoriteRepository;

  @override
  Future<DataState<List<FavoriteModel>>> call(String token) {
    return _favoriteRepository.getFavoriteList(
      token,
    );
  }
}
