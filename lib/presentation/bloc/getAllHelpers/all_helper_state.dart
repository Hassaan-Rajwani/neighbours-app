part of 'all_helper_bloc.dart';

sealed class AllHelperState extends Equatable {
  const AllHelperState();

  @override
  List<Object> get props => [];
}

final class AllHelperInitial extends AllHelperState {}

class GetHelperInProgress extends AllHelperState {}

class AllHelperStateSuccessful extends AllHelperState {
  const AllHelperStateSuccessful({
    required this.list,
  });

  final List<AllHelpersModel> list;
  @override
  List<Object> get props => [list];
}

class GetHelperError extends AllHelperState {
  const GetHelperError({required this.error});
  final String error;
}
