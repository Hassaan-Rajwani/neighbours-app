// ignore_for_file: deprecated_member_use,
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/mappers/api_response_map.dart';
import 'package:neighbour_app/data/sources/userApis/user_api.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/notification/notification_bloc.dart';
import 'package:neighbour_app/utils/storage.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._userApiService);
  final UserApiService _userApiService;

  @override
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      if (response.nextStep.signInStep == AuthSignInStep.done) {
        final authSession = await Amplify.Auth.fetchAuthSession(
          options: const FetchAuthSessionOptions(
            pluginOptions: CognitoFetchAuthSessionPluginOptions(),
          ),
        ) as CognitoAuthSession;
        final token = authSession.userPoolTokens!.accessToken.raw;
        await setDataToStorage(StorageKeys.userToken, token);
        final fcm = await getDataFromStorage(StorageKeys.fcm);
        sl<NotificationBloc>().add(
          PostFcmTokenEvent(
            body: {
              'fcm_token': fcm,
            },
          ),
        );
        return null;
      } else if (response.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
        return 'confirm';
      }
    } on AuthException catch (e) {
      safePrint('Error signing user: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> googleSignin() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
        options: const SignInWithWebUIOptions(
          pluginOptions: CognitoSignInWithWebUIPluginOptions(
            isPreferPrivateSession: true,
          ),
        ),
      );
      if (result.isSignedIn) {
        final authSession = await Amplify.Auth.fetchAuthSession(
          options: const FetchAuthSessionOptions(
            pluginOptions: CognitoFetchAuthSessionPluginOptions(),
          ),
        ) as CognitoAuthSession;
        final token = authSession.userPoolTokens!.accessToken.raw;
        await setDataToStorage(StorageKeys.userToken, token);
        final fcm = await getDataFromStorage(StorageKeys.fcm);
        sl<NotificationBloc>().add(
          PostFcmTokenEvent(
            body: {
              'fcm_token': fcm,
            },
          ),
        );
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> signUp({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.givenName: firstName,
        AuthUserAttributeKey.familyName: lastName,
      };
      final response = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      if (response.nextStep.signUpStep == AuthSignUpStep.confirmSignUp) {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> forgotPassword({required String email}) async {
    try {
      final response = await Amplify.Auth.resetPassword(
        username: email,
      );
      if (response.nextStep.updateStep ==
          AuthResetPasswordStep.confirmResetPasswordWithCode) {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error forgotPassword: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> resendEmailVerification({required String email}) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);
    } on AuthException catch (e) {
      safePrint('Error resendVerification: ${e.message}');
      return e.message;
    }
    return null;
  }

  @override
  Future<String?> forgotPasswordResendCode({required String email}) async {
    try {
      final response = await Amplify.Auth.resetPassword(username: email);
      if (response.nextStep.updateStep ==
          AuthResetPasswordStep.confirmResetPasswordWithCode) {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error forgotPassword: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> resetPassword({
    required String otp,
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await Amplify.Auth.confirmResetPassword(
        username: email,
        confirmationCode: otp,
        newPassword: newPassword,
      );
      if (response.isPasswordReset) {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error forgotPasswordverifictaion: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        options: const UpdatePasswordOptions(
          pluginOptions: CognitoUpdatePasswordPluginOptions(),
        ),
      );
      if (response.runtimeTypeName == 'UpdatePasswordResult') {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error changePassword: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<String?> emailVerification({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: otp,
      );
      if (response.nextStep.signUpStep == AuthSignUpStep.done) {
        return null;
      }
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      return e.message;
    }
    return '';
  }

  @override
  Future<bool> logout() async {
    try {
      final isFcmDeleted = await userLogout();
      if (isFcmDeleted.data == null) {
        await Future.wait([
          deleteDataFromStorage(StorageKeys.userToken),
          deleteDataFromStorage(StorageKeys.jobSize),
          deleteDataFromStorage(StorageKeys.jobSorting),
          deleteDataFromStorage(StorageKeys.jobRating),
          deleteDataFromStorage(StorageKeys.jobPickupType),
          deleteDataFromStorage(StorageKeys.jobDistance),
          deleteDataFromStorage(StorageKeys.hJobSize),
          deleteDataFromStorage(StorageKeys.hJobSorting),
          deleteDataFromStorage(StorageKeys.hJjobRating),
          deleteDataFromStorage(StorageKeys.hJobPickupType),
          deleteDataFromStorage(StorageKeys.hJobDistance),
          deleteDataFromStorage(StorageKeys.helperNeighbrDistance),
          deleteDataFromStorage(StorageKeys.helperNeighbrRating),
        ]);
        final result = Platform.isIOS
            ? await Amplify.Auth.signOut(
                options: const SignOutOptions(
                  globalSignOut: true,
                  pluginOptions: CognitoSignOutPluginOptions(),
                ),
              )
            : await Amplify.Auth.signOut();
        if (result is CognitoCompleteSignOut) {
          return true;
        }
      }
    } on AuthException catch (e) {
      safePrint('Error signout up user: ${e.message}');
    }
    return false;
  }

  @override
  Future<DataState<String?>> deleteAccount({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      final httpResponse = await _userApiService.deactivateAccount(
        authToken: 'Bearer $token',
        body: body,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data!['acknowledged'] == true) {
          return const DataSuccess(null);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String?>> postFcm({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    try {
      final httpResponse = await _userApiService.postFcm(
        authToken: 'Bearer $token',
        body: body,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = APIResponseMap.fromJson(httpResponse.data);
        if (response.data != null) {
          return const DataSuccess(null);
        }
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<String?>> userLogout() async {
    try {
      final token = await getDataFromStorage(StorageKeys.userToken);
      final httpResponse = await _userApiService.logout(
        authToken: 'Bearer $token',
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return const DataSuccess(null);
      }
      return DataFailed(
        DioException(
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          message: httpResponse.response.statusMessage,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
