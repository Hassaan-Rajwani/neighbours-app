import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/domain/repository/neighbor_favorite_repository.dart';

class AddFavoriteBody {
  AddFavoriteBody({required this.token, required this.favorite});

  final String token;
  final AddFavorite favorite;
}

class AddFavoriteUseCase
    implements UseCase<DataState<String?>, AddFavoriteBody> {
  AddFavoriteUseCase(this._favoriteRepository);

  final NeighborFavoriteRepository _favoriteRepository;

  @override
  Future<DataState<String?>> call(AddFavoriteBody body) {
    return _favoriteRepository.addFavorite(body.token, body.favorite);
  }
}
