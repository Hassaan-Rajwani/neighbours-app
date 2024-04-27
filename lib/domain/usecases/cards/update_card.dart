import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';

class UpdateCardParms {
  UpdateCardParms({
    required this.id,
    required this.token,
  });

  String id;
  String token;
}

class UpdateCardUseCase
    implements UseCase<DataState<String?>, UpdateCardParms> {
  UpdateCardUseCase(this._updateRepository);

  final CardRepository _updateRepository;

  @override
  Future<DataState<String?>> call(UpdateCardParms parms) {
    return _updateRepository.updateCard(
      id: parms.id,
      token: parms.token,
    );
  }
}
