import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/helper_stripe_model.dart';
import 'package:neighbour_app/domain/repository/stripe_login_repository.dart';

class AddStripeUseCase
    implements UseCase<DataState<HelperStripeModel>, String> {
  AddStripeUseCase(this._stripeRepository);

  final StripeRepository _stripeRepository;

  @override
  Future<DataState<HelperStripeModel>> call(String token) {
    return _stripeRepository.addCard(token: token);
  }
}
