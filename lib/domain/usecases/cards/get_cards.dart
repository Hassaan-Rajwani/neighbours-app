import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/card_model.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';

class GetCardListUseCase
    implements UseCase<DataState<List<CardModel>>, String> {
  GetCardListUseCase(this._cardRepository);

  final CardRepository _cardRepository;

  @override
  Future<DataState<List<CardModel>>> call(String token) {
    return _cardRepository.getCardList(token);
  }
}
