// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';

abstract class HelpersPackageRepository {
  Future<DataState<String?>> createPackage(
    Map<String, dynamic> body,
    String token,
    String jobId,
  );

  Future<DataState<List<NeighborsPackageModel>>> getPackage(
    String token,
    String jobId,
  );
}
