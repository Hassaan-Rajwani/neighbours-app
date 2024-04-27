part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

class CardsInitial extends CardsState {}

class GetCardsInProgress extends CardsState {}

class GetCardListState extends CardsState {
  const GetCardListState({required this.list});

  final List<CardModel> list;
}

class GetCardsListError extends CardsState {
  const GetCardsListError({required this.error});
  final String error;
}
