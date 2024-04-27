import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/card_model.dart';
import 'package:neighbour_app/data/models/payment_model.dart';

abstract class CardRepository {
  Future<DataState<List<CardModel>>> getCardList(String token);
  Future<DataState<String?>> deleteCard({
    required String id,
    required String token,
  });
  Future<DataState<String?>> updateCard({
    required String id,
    required String token,
  });
  Future<DataState<StripeModel>> addCard({required String token});
}
