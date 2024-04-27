import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/user.dart';

abstract class UserRepository {
  Future<DataState<UserModel>> getProfile(String token);

  Future<DataState<String?>> deleteAccount(String token);
  Future<DataState<String?>> editProfile({
    required Map<String, dynamic> body,
    required String token,
  });
}
