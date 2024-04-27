part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteListEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  const AddFavoriteEvent({required this.body, required this.token});

  final String token;
  final AddFavorite body;
}

class DeleteFavoriteEvent extends FavoriteEvent {
  const DeleteFavoriteEvent({
    required this.favoriteID,
  });

  final String favoriteID;
}
