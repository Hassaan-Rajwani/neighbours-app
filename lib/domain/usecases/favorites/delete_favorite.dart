import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/neighbor_favorite_repository.dart';

class DeleteFavoriteBody {
  DeleteFavoriteBody({required this.token, required this.favoriteID});

  final String token;
  final String favoriteID;
}

class DeleteFavoriteUseCase
    implements UseCase<DataState<String?>, DeleteFavoriteBody> {
  DeleteFavoriteUseCase(this._favoriteRepository);

  final NeighborFavoriteRepository _favoriteRepository;

  @override
  Future<DataState<String?>> call(DeleteFavoriteBody body) {
    return _favoriteRepository.deleteFavorite(body.token, body.favoriteID);
  }
}
