// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/bids.dart';

abstract class NeighborBidsRepository {
  Future<DataState<List<BidsModel>>> getNeighborBids(
    String token,
    String jobId,
  );

  Future<DataState<String?>> neighborBidAccept({
    required String token,
    required String jobId,
    required String bidId,
  });
  Future<DataState<String?>> putRejectBid({
    required String token,
    required String jobId,
    required String bidId,
  });
}
