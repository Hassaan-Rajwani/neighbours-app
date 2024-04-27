// ignore_for_file: unused_element, body_might_complete_normally_nullable
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/auth/change_password.dart';
import 'package:neighbour_app/domain/usecases/auth/deactivate_account.dart';
import 'package:neighbour_app/domain/usecases/auth/email_verification.dart';
import 'package:neighbour_app/domain/usecases/auth/forgot_password.dart';
import 'package:neighbour_app/domain/usecases/auth/google_auth_usecase.dart';
import 'package:neighbour_app/domain/usecases/auth/logout.dart';
import 'package:neighbour_app/domain/usecases/auth/reset_password.dart';
import 'package:neighbour_app/domain/usecases/auth/signin.dart';
import 'package:neighbour_app/domain/usecases/auth/signup.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._logoutUseCase,
    this._resetPasswordUseCase,
    this._forgotPasswordUseCase,
    this._emailVerificationUseCase,
    this._forgotPasswordResendCodeUseCase,
    this._resendEmailVerificationUseCase,
    this._onDeactivateAccount,
    this._changePasswordUseCase,
    this._googleAuthUseCase,
  ) : super(AuthStateInitial()) {
    on<AuthSignUpEvent>(_onSignup);
    on<AuthSignInEvent>(_onSignin);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthSplashEvent>(_onSplashComplete);
    on<AuthUserTypeEvent>(_checkUserType);
    on<AuthResetPassword>(_onResetPassword);
    on<AuthVerificationEmailEvent>(_onVerficationEmail);
    on<AuthResendVerificationEmailEvent>(_onResendVerficationEmail);
    on<AuthForgotPasswordEvent>(_onForgotPassword);
    on<AuthForgotPasswordResendCodeEvent>(_onForgotPasswordResendCode);
    on<AccountDeactivateEvent>(_accountDeactivate);
    on<AuthChangePassword>(_onChangePassword);
    on<GoogleAuthEvent>(_googleAuth);
  }

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final DeactivateUseCase _onDeactivateAccount;
  final ChangePasswordUseCase _changePasswordUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final EmailVerificationUseCase _emailVerificationUseCase;
  final ResendEmailVerificationUseCase _resendEmailVerificationUseCase;
  final ForgotPasswordResendCodeUseCase _forgotPasswordResendCodeUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;

  Future<void> _onSplashComplete(
    AuthSplashEvent event,
    Emitter<AuthState> emit,
  ) async {
    final onboardingStatus = await getDataFromStorage(
      StorageKeys.onboardingComplete,
    );
    if (onboardingStatus == null) {
      emit(AuthStateOnboarding());
      return;
    }

    final isAuthed = await getDataFromStorage(StorageKeys.userToken);
    if (isAuthed != null) {
      emit(const AuthStateUserType());
      sl<ProfileBloc>().add(GetUserProfileEvent());
      sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
      sl<JobsBloc>().add(const GetPendingJobEvent());
      sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
      await setDataToStorage(StorageKeys.addressLable, 'OTHER');
    } else {
      emit(AuthStateSignedOut());
    }
  }

  Future<void> _checkUserType(
    AuthUserTypeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateUserType(userType: event.type));
  }

  Future<void> _onSignin(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateSignInProgress());

    final params = SignInParams(email: event.email, password: event.password);
    final dataState = await _signInUseCase(params);

    if (dataState == null) {
      emit(AuthStateSignInSuccessful());
      sl<ProfileBloc>().add(GetUserProfileEvent());
      sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
      sl<JobsBloc>().add(const GetPendingJobEvent());
      sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
      await setDataToStorage(StorageKeys.addressLable, 'OTHER');
      emit(const AuthStateUserType());
    } else if (dataState == 'confirm') {
      emit(ConfirmEmailOnLoginState(email: event.email));
    } else {
      emit(AuthStateSignInError(dataState));
    }
  }

  Future<void> _googleAuth(
    GoogleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(GoogleAuthInProgress());
    final dataState = await _googleAuthUseCase(GoogleAuthParms());
    if (dataState == null) {
      emit(GoogleAuthSuccessful());
      sl<ProfileBloc>().add(GetUserProfileEvent());
      sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
      sl<JobsBloc>().add(const GetPendingJobEvent());
      sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
      await setDataToStorage(StorageKeys.addressLable, 'OTHER');
      emit(const AuthStateUserType());
    } else {
      emit(GoogleAuthError(dataState));
    }
  }

  Future<void> _onSignup(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateSignUpInProgress());

    final params = SignUpParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
    );
    final dataState = await _signUpUseCase(params);

    if (dataState == null) {
      emit(AuthStateSignUpSuccessful(email: event.email));
    } else {
      emit(AuthStateSignUpError(dataState));
    }
  }

  Future<void> _onVerficationEmail(
    AuthVerificationEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateEmailVerificationProgress());

    final params = EmailVerificationParams(email: event.email, otp: event.otp);
    final dataState = await _emailVerificationUseCase(params);

    if (dataState == null) {
      emit(AuthStateEmailVerifiedSuccessfully());
    } else {
      emit(AuthStateEmailVerifiedError(dataState));
    }
  }

  Future<void> _onResendVerficationEmail(
    AuthResendVerificationEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    final params = ResendEmailVerificationParams(email: event.email);
    final dataState = await _resendEmailVerificationUseCase(params);

    if (dataState == null) {
      emit(AuthStateResendEmailVerifiedSuccessfully());
    } else {
      emit(AuthStateResendEmailVerifiedError(dataState));
    }
  }

  Future<void> _onForgotPassword(
    AuthForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateForgotPasswordInProgress());

    final params = ForgotPasswordParams(email: event.email);
    final dataState = await _forgotPasswordUseCase(params);

    if (dataState == null) {
      emit(AuthStateForgotPasswordSuccessfully());
    } else {
      emit(AuthStateForgotPasswordError(dataState));
    }
  }

  Future<void> _onForgotPasswordResendCode(
    AuthForgotPasswordResendCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    final params = ForgotPasswordResendCodeParams(email: event.email);
    final dataState = await _forgotPasswordResendCodeUseCase(params);

    if (dataState == null) {
      emit(AuthStateForgotPasswordResendCodeSuccessfully());
    } else {
      emit(AuthStateForgotPasswordResendCodeError(dataState));
    }
  }

  Future<void> _onResetPassword(
    AuthResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateResetPasswordInProgress());

    final params = ResetPasswordParams(
      email: event.email,
      otp: event.otp,
      newPassword: event.newPassword,
    );
    final dataState = await _resetPasswordUseCase(params);

    if (dataState == null) {
      emit(AuthStateResetPasswordSuccessfully());
    } else {
      emit(AuthStateResetPasswordError(dataState));
    }
  }

  Future<void> _onChangePassword(
    AuthChangePassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateChangePasswordInProgress());

    final params = ChangePasswordParams(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    );
    final dataState = await _changePasswordUseCase(params);

    if (dataState == null) {
      emit(AuthStateChangePasswordSuccessfully());
    } else {
      emit(AuthStateChangePasswordError(dataState));
    }
  }

  Future<void> _onLogout(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateSignedOutInProgress());

    final dataState = await _logoutUseCase(LogoutParms());

    if (dataState) {
      emit(AuthStateSignedOut());
    } else if (!dataState) {
      emit(AuthStateSignedOutError());
    }
  }

  Future<String?> _accountDeactivate(
    AccountDeactivateEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AccountDeactivateInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = DeactivateAccount(
        body: event.body,
        token: token,
      );
      final dataState = await _onDeactivateAccount(params);
      if (dataState.data == null) {
        emit(AccountDeactivateSuccessfully());
      } else {
        emit(AccountDeactivateError(error: dataState.error!.message!));
      }
    }
  }
}
