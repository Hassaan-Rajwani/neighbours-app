import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/card_model.dart';
import 'package:neighbour_app/domain/usecases/cards/delete_card.dart';
import 'package:neighbour_app/domain/usecases/cards/get_cards.dart';
import 'package:neighbour_app/domain/usecases/cards/update_card.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc(
    this._getCardListUseCase,
    this._updateCardUseCase,
    this._deleteCardUseCase,
  ) : super(CardsInitial()) {
    on<GetCardsListEvent>(_getCardList);
    on<DeleteCardEvent>(_deleteCard);
    on<UpdateCardEvent>(_updateCard);
  }

  final GetCardListUseCase _getCardListUseCase;
  final UpdateCardUseCase _updateCardUseCase;
  final DeleteCardUseCase _deleteCardUseCase;

  Future<void> _getCardList(
    GetCardsListEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(GetCardsInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getCardListUseCase(token);
      if (dataState.data != null) {
        emit(GetCardListState(list: dataState.data!));
      } else {
        emit(GetCardsListError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _deleteCard(
    DeleteCardEvent event,
    Emitter<CardsState> emit,
  ) async {
    final params = DeleteCardParms(
      id: event.id,
      token: event.token,
    );
    await _deleteCardUseCase(params);
  }

  Future<void> _updateCard(
    UpdateCardEvent event,
    Emitter<CardsState> emit,
  ) async {
    final token = await getDataFromStorage(
      StorageKeys.userToken,
    );
    if (token != null) {
      final params = UpdateCardParms(
        id: event.id,
        token: token,
      );
      await _updateCardUseCase(params);
    }
  }
}
