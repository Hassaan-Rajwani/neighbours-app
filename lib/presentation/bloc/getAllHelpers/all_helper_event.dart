// ignore_for_file: must_be_immutable
part of 'all_helper_bloc.dart';

sealed class AllHelperEvent extends Equatable {
  const AllHelperEvent();

  @override
  List<Object> get props => [];
}

class GetAllHelpersEvent extends AllHelperEvent {
  GetAllHelpersEvent({
    required this.rating,
    required this.miles,
  });

  int rating;
  int miles;
}
