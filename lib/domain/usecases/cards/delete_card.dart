import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';

class DeleteCardParms {
  DeleteCardParms({
    required this.id,
    required this.token,
  });

  String id;
  String token;
}

class DeleteCardUseCase
    implements UseCase<DataState<String?>, DeleteCardParms> {
  DeleteCardUseCase(this._updateRepository);

  final CardRepository _updateRepository;

  @override
  Future<DataState<String?>> call(DeleteCardParms parms) {
    return _updateRepository.deleteCard(
      id: parms.id,
      token: parms.token,
    );
  }
}
