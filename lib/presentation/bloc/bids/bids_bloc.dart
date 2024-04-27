// ignore_for_file: body_might_complete_normally_nullable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/bids.dart';
import 'package:neighbour_app/domain/usecases/bids/get_neighbor_bids.dart';
import 'package:neighbour_app/domain/usecases/bids/neighbor_bid_accept.dart';
import 'package:neighbour_app/domain/usecases/bids/put_neighbor_bids_reject.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'bids_event.dart';
part 'bids_state.dart';

class BidsBloc extends Bloc<BidsEvent, BidsState> {
  BidsBloc(
    this._getNeighborBidsUseCase,
    this._neighborBidAcceptUseCase,
    this._neighborBidRejectUseCase,
  ) : super(BidsInitial()) {
    on<GetNeighborBidsEvent>(_getNeighborBids);
    on<NeighborBidAcceptEvent>(_neighborBidAccept);
    on<NeighborBidRejectEvent>(_neighborBidReject);
  }

  final GetNeighborBidsUseCase _getNeighborBidsUseCase;
  final NeighborBidAcceptUseCase _neighborBidAcceptUseCase;
  final NeighborBidRejectCase _neighborBidRejectUseCase;

  Future<void> _getNeighborBids(
    GetNeighborBidsEvent event,
    Emitter<BidsState> emit,
  ) async {
    emit(GetNeighborBidsInprogress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetNeighborBidsBody(token: token, jobId: event.jobId);
      final dataState = await _getNeighborBidsUseCase(params);
      if (dataState.data != null) {
        emit(GetNeighborBidsSuccessfull(list: dataState.data!));
      } else {
        emit(GetNeighborBidsError(dataState.toString()));
      }
    }
  }

  Future<void> _neighborBidAccept(
    NeighborBidAcceptEvent event,
    Emitter<BidsState> emit,
  ) async {
    final params = NeighborBidAcceptBody(
      token: event.token,
      jobId: event.jobId,
      bidId: event.bidId,
    );
    final dataState = await _neighborBidAcceptUseCase(params);
    if (dataState.data == null) {
      sl<JobsBloc>().add(
        const GetPendingJobEvent(),
      );
      emit(NeighborBidAcceptSuccessfull());
    } else {
      emit(NeighborBidAcceptError(dataState.toString()));
    }
  }

  Future<void> _neighborBidReject(
    NeighborBidRejectEvent event,
    Emitter<BidsState> emit,
  ) async {
    final params = NeighborBidRejectBody(
      token: event.token,
      jobId: event.jobId,
      bidId: event.bidId,
    );
    await _neighborBidRejectUseCase(params);
  }
}
