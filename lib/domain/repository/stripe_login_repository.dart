// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/helper_stripe_model.dart';

abstract class StripeRepository {
  Future<DataState<HelperStripeModel>> addCard({required String token});
}
