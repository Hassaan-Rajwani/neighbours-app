// ignore_for_file: one_member_abstracts
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/another_user_model.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';

abstract class HelperRepository {
  Future<DataState<AnotherUserModel>> getAnotherUser({
    required String token,
    required String helperId,
  });
  Future<DataState<List<AllHelpersModel>>> getHelpersList({
    required String token,
    required int rating,
    required int miles,
  });
}
