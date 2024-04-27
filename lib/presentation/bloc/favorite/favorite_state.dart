part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class GetFavoriteListInprogress extends FavoriteState {}

class FavoriteListSuccessFull extends FavoriteState {
  const FavoriteListSuccessFull({required this.list});

  final List<FavoriteModel> list;
}

class FavoriteListError extends FavoriteState {
  const FavoriteListError({required this.error});
  final String error;
}

class AddFavoriteInprogress extends FavoriteState {}

class AddFavoriteSuccessfull extends FavoriteState {}

class AddFavoriteError extends FavoriteState {
  const AddFavoriteError({required this.error});
  final String error;
}

class DeleteFavoiteInprogress extends FavoriteState {}

class DeleteFavoiteSuccessfull extends FavoriteState {}

class DeleteFavoiteError extends FavoriteState {
  const DeleteFavoiteError({required this.error});
  final String error;
}
