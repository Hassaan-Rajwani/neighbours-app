part of 'get_another_user_bloc.dart';

sealed class GetAnotherUserState extends Equatable {
  const GetAnotherUserState();

  @override
  List<Object> get props => [];
}

final class GetAnotherUserInitial extends GetAnotherUserState {}

class GetAnotherUserSuccessfull extends GetAnotherUserState {
  const GetAnotherUserSuccessfull({required this.helperId});
  final AnotherUserModel helperId;
}

class GetAnotherUserError extends GetAnotherUserState {
  const GetAnotherUserError({required this.error});
  final String error;
}

class GetAnotherUserInprogress extends GetAnotherUserState {}
