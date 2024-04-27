part of 'get_another_user_bloc.dart';

sealed class GetAnotherUserEvent extends Equatable {
  const GetAnotherUserEvent();

  @override
  List<Object> get props => [];
}

class GetAnotherUser extends GetAnotherUserEvent {
  const GetAnotherUser({
    required this.helperId,
  });

  final String helperId;
}
