part of 'get_by_id_bloc.dart';

sealed class GetByIdEvent extends Equatable {
  const GetByIdEvent();

  @override
  List<Object> get props => [];
}

class GetJobByIdEvent extends GetByIdEvent {
  const GetJobByIdEvent({
    required this.jobId,
  });

  final String jobId;
}
