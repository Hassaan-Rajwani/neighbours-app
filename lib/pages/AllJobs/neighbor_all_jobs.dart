// ignore_for_file: unused_local_variable, lines_longer_than_80_chars, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/job_card_widget.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/neighbr_all_job_searchbar.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/neighbor_job_detail.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';

class NeighborAllJobsPage extends StatefulWidget {
  const NeighborAllJobsPage({
    this.packageData,
    super.key,
  });

  static const routeName = '/neighbor-all-jobs';
  final List<NeighborsPackageModel>? packageData;

  @override
  State<NeighborAllJobsPage> createState() => _NeighborAllJobsPageState();
}

class _NeighborAllJobsPageState extends State<NeighborAllJobsPage> {
  List<JobModelWithHelperInfo> _filterJobtList = [];

  @override
  void initState() {
    super.initState();
    deleteDataFromStorage(StorageKeys.jobSize);
    deleteDataFromStorage(StorageKeys.jobSorting);
    deleteDataFromStorage(StorageKeys.jobRating);
    deleteDataFromStorage(StorageKeys.jobPickupType);
    deleteDataFromStorage(StorageKeys.jobDistance);
    sl<JobsBloc>().add(const GetPendingJobEvent());

    final state = context.read<JobsBloc>().state;
    if (state is GetPendingJobSuccessfull) {
      _filterJobtList = state.activeList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsBloc, JobsState>(
      builder: (context, jobState) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: backButtonAppbar(
            context,
            icon: const Icon(Icons.arrow_back),
            backgroundColor: Colors.white,
            text: 'Your Jobs',
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (jobState is GetPendingJobInprogress)
                  const CircularLoader(height: 80),
                if (jobState is GetPendingJobSuccessfull)
                  Expanded(
                    child: Column(
                      children: [
                        const Gap(
                          gap: 15,
                        ),
                        NeighbrAllJobSearchBarAndButton(
                          onChangeText: (text) {
                            setState(() {
                              _filterJobtList = jobState.activeList
                                  .where(
                                    (contact) =>
                                        contact.title.toLowerCase().contains(
                                              text.toLowerCase(),
                                            ),
                                  )
                                  .toList();
                            });
                          },
                          jobOnTap: (
                            distance,
                            size,
                            order,
                            pickupType,
                            rating,
                          ) {
                            _filterJobtList.clear();
                            final formatedMiles =
                                double.parse(distance.toString())
                                    .toStringAsFixed(1);
                            final formatedSize = checkSize(size);
                            final formatedOrder = checkOrder(order);
                            final formatedPackageType =
                                checkPackageType(pickupType);
                            final formatedRating = int.parse(
                              rating.toString().substring(0, 1),
                            );
                            sl<JobsBloc>().add(
                              GetPendingJobEvent(
                                distance: double.parse(formatedMiles),
                                order: formatedOrder,
                                pickupType: formatedPackageType,
                                size: formatedSize,
                                rating: formatedRating,
                              ),
                            );
                            context.pop();
                          },
                          jobOnReset: () {
                            deleteDataFromStorage(StorageKeys.jobSize);
                            deleteDataFromStorage(
                              StorageKeys.jobSorting,
                            );
                            deleteDataFromStorage(
                              StorageKeys.jobRating,
                            );
                            deleteDataFromStorage(
                              StorageKeys.jobPickupType,
                            );
                            deleteDataFromStorage(
                              StorageKeys.jobDistance,
                            );
                            _filterJobtList.clear();
                            sl<JobsBloc>().add(
                              const GetPendingJobEvent(),
                            );
                            context.pop();
                          },
                        ),
                        const Gap(
                          gap: 15,
                        ),
                        if (jobState.activeList.isEmpty)
                          const NoJobsWidget(
                            text: 'No Active Jobs at the moment',
                          )
                        else if (_filterJobtList.isNotEmpty)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeHelper.moderateScale(20),
                              ),
                              child: ListView.builder(
                                itemCount: _filterJobtList.length,
                                itemBuilder: (context, index) {
                                  final currentItem = _filterJobtList[index];
                                  return JobCardWidget(
                                    firstName: currentItem.helperId!.firstName,
                                    lastName: currentItem.helperId!.lastName,
                                    stars: currentItem.helperId!.helper.rating,
                                    isSelected: true,
                                    image1: currentItem.helperId!.imageUrl
                                        .toString(),
                                    image2: allJobSuitcaseIcon,
                                    label:
                                        ''' ${currentItem.helperId!.firstName} ${currentItem.helperId!.lastName}''',
                                    sublabel: currentItem.title,
                                    packageLength: currentItem.packages,
                                    jobStatus: currentItem.status,
                                    onViewTap: () async {
                                      final query = Uri(
                                        queryParameters: {
                                          'jobId': currentItem.id,
                                        },
                                      ).query;
                                      await context.push(
                                        '${NeighborJobDetailPage.routeName}?$query',
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        else
                          const NoJobsWidget(
                            text: 'No Job Available',
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
