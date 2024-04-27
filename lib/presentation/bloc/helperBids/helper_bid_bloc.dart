import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/domain/usecases/helperBids/create_bid.dart';
import 'package:neighbour_app/domain/usecases/helperBids/reject_bid.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';

part 'helper_bid_event.dart';
part 'helper_bid_state.dart';

class HelperBidBloc extends Bloc<HelperBidEvent, HelperBidState> {
  HelperBidBloc(
    this._helperCreateBidUseCase,
    this._helperRejectBidUseCase,
  ) : super(HelperBidInitial()) {
    on<HelperCreateBidEvent>(_helperCreateBid);
    on<HelperRejectBidEvent>(_helperRejectBid);
  }

  final CreateBidUseCase _helperCreateBidUseCase;
  final RejectBidUseCase _helperRejectBidUseCase;

  Future<void> _helperCreateBid(
    HelperCreateBidEvent event,
    Emitter<HelperBidState> emit,
  ) async {
    final params = CreateBidBody(
      token: event.token,
      body: event.body,
      bidId: event.bidId,
    );
    await _helperCreateBidUseCase(params);
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
  }

  Future<void> _helperRejectBid(
    HelperRejectBidEvent event,
    Emitter<HelperBidState> emit,
  ) async {
    final params = RejectBidBody(
      token: event.token,
      jobId: event.jobId,
    );
    await _helperRejectBidUseCase(params);
  }
}
