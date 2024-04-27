// ignore_for_file: one_member_abstracts

import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/data/models/helpers_count_job.dart';

abstract class HelpersCountJobRepository {
  Future<DataState<CountJobModel>> getJobCount(String token, String jobStatus);
}
