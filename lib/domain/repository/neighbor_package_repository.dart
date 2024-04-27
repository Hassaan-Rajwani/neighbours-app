import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';

abstract class NeighborPackageRepository {
  Future<DataState<List<NeighborsPackageModel>>> getNeighborsPacakge(
    String token,
    String jobId,
  );
  Future<DataState<String?>> updateNeighborsPackage(
    String token,
    String jobId,
    String packageId,
  );
  Future<DataState<String?>> giveTip(
    String token,
    Map<String, dynamic> tipBody,
  );
}
