part of 'helper_jobs_bloc.dart';

sealed class HelperJobsEvent extends Equatable {
  const HelperJobsEvent();

  @override
  List<Object> get props => [];
}

class GetHelperAllJobsEvent extends HelperJobsEvent {
  const GetHelperAllJobsEvent({
    this.rating = 0,
    this.size = 'null',
    this.order = 'null',
    this.pickupType = 'null',
    this.distance = 0.0,
  });
  final int? rating;
  final String? size;
  final String? order;
  final String? pickupType;
  final double? distance;
}
