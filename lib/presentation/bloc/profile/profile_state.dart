part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({
    this.id = '',
    this.email = '',
    this.lastName = '',
    this.firstName = '',
    this.cognitoID = '',
    this.active = false,
    this.bankDetails = false,
    this.stripeCustomerAccountID = '',
    this.stripeHelperAccountID = '',
    this.description,
    this.imageUrl,
  });

  final String id;
  final String email;
  final bool active;
  final bool bankDetails;
  final String lastName;
  final String firstName;
  final String cognitoID;
  final String? description;
  final String? imageUrl;
  final String stripeHelperAccountID;
  final String stripeCustomerAccountID;
}

class ProfileError extends ProfileState {
  const ProfileError({required this.error});
  final String error;
}

class EditProfileInProgress extends ProfileState {}

class GetProfileInProgress extends ProfileState {}

class DeleteAccountInProgress extends ProfileState {}

class EditProfileSuccessfull extends ProfileState {}

class DeleteAccountSuccessfull extends ProfileState {}

class EditProfileError extends ProfileState {
  const EditProfileError({required this.error});
  final String error;
}

class DeleteAccountError extends ProfileState {
  const DeleteAccountError({required this.error});
  final String error;
}
