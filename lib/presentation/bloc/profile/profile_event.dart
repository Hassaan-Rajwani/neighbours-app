part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  const EditProfileEvent({
    required this.body,
  });

  final Map<String, dynamic> body;
}

class DeleteProfileEvent extends ProfileEvent {}
