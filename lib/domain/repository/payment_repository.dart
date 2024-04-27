// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/payment_model.dart';

abstract class PaymentRepository {
  Future<DataState<StripeModel>> getPaymentIntent({required String token});
}
