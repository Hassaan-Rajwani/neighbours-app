import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/payment_model.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';

class AddCardUseCase implements UseCase<DataState<StripeModel>, String> {
  AddCardUseCase(this._cardRepository);

  final CardRepository _cardRepository;

  @override
  Future<DataState<StripeModel>> call(String token) {
    return _cardRepository.addCard(token: token);
  }
}
