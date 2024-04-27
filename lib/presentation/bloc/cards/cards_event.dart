part of 'cards_bloc.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class GetCardsListEvent extends CardsEvent {}

class DeleteCardEvent extends CardsEvent {
  const DeleteCardEvent({required this.id, required this.token});

  final String id;
  final String token;
}

class UpdateCardEvent extends CardsEvent {
  const UpdateCardEvent({
    required this.id,
  });

  final String id;
}
