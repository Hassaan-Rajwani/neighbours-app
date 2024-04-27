import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/user/delete_account_usecase.dart';
import 'package:neighbour_app/domain/usecases/user/get_profile.dart';
import 'package:neighbour_app/domain/usecases/user/update_profile.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getProfileUsecase,
    this._editProfileUseCase,
    this._deleteProfileUseCase,
  ) : super(GetProfileInProgress()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<EditProfileEvent>(_updateProfile);
    on<DeleteProfileEvent>(_deleteAccount);
  }

  final GetProfileUseCase _getProfileUsecase;
  final EditProfileUseCase _editProfileUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  Future<void> _onGetUserProfile(
    GetUserProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(GetProfileInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _getProfileUsecase(token);
      if (dataState.data != null) {
        emit(
          ProfileInitial(
            email: dataState.data!.email,
            active: dataState.data!.active,
            cognitoID: dataState.data!.cognitoID,
            description: dataState.data!.description,
            firstName: dataState.data!.firstName,
            id: dataState.data!.id,
            lastName: dataState.data!.lastName,
            stripeCustomerAccountID: dataState.data!.stripeCustomerAccountID,
            stripeHelperAccountID: dataState.data!.stripeHelperAccountID,
            imageUrl: dataState.data!.imageUrl,
            bankDetails: dataState.data!.bankDetails,
          ),
        );
      } else {
        emit(ProfileError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _updateProfile(
    EditProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(EditProfileInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    final params = EditProfileParms(
      body: event.body,
      token: token!,
    );
    final dataState = await _editProfileUseCase(params);
    if (dataState.data == null) {
      sl<ProfileBloc>().add(GetUserProfileEvent());
      emit(EditProfileSuccessfull());
    } else {
      emit(EditProfileError(error: dataState.error!.message!));
    }
  }

  Future<void> _deleteAccount(
    DeleteProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(DeleteAccountInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final dataState = await _deleteProfileUseCase(token);
      if (dataState.data == null) {
        emit(DeleteAccountSuccessfull());
      } else {
        emit(DeleteAccountError(error: dataState.error!.message!));
      }
    }
  }
}
