part of 'get_by_id_bloc.dart';

sealed class GetByIdState extends Equatable {
  const GetByIdState();

  @override
  List<Object> get props => [];
}

final class GetByIdInitial extends GetByIdState {}

class GetJobByIdSuccessfull extends GetByIdState {
  const GetJobByIdSuccessfull({required this.job});
  final JobByIdModel job;
}

class GetJobByIdError extends GetByIdState {
  const GetJobByIdError({required this.error});
  final String error;
}

class GetJobByIdInprogress extends GetByIdState {}
