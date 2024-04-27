import 'package:neighbour_app/core/resources/data_state.dart';

abstract class AuthenticationRepository {
  Future<bool> logout();
  Future<String?> googleSignin();
  Future<String?> signIn({required String email, required String password});
  Future<String?> emailVerification({
    required String email,
    required String otp,
  });
  Future<String?> forgotPassword({required String email});
  Future<String?> forgotPasswordResendCode({required String email});
  Future<String?> resendEmailVerification({required String email});
  Future<String?> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
  Future<String?> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<String?> signUp({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  });

  Future<DataState<String?>> deleteAccount({
    required String token,
    required Map<String, dynamic> body,
  });

  Future<DataState<String?>> postFcm({
    required String token,
    required Map<String, dynamic> body,
  });
}
