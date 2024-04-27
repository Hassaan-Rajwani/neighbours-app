// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/job_card_widget.dart';
import 'package:neighbour_app/pages/HelperJobDetail/helper_job_detail.dart';
import 'package:neighbour_app/pages/openJobs/widgets/helper_all_job_searchbar.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';

class HelperOpenJobs extends StatefulWidget {
  const HelperOpenJobs({super.key});

  static const routeName = '/helper-open-jobs';

  @override
  State<HelperOpenJobs> createState() => _HelperOpenJobsState();
}

class _HelperOpenJobsState extends State<HelperOpenJobs> {
  final List<Map<String, dynamic>> filterData = [
    {'label': 'Filter By Package', 'image': jobHistory},
    {'label': 'Sort by', 'image': sortIcon},
  ];
  List<HelperActiveJobModel> _filterJobtList = [];

  Future<void> _onrefresh() async {
    _filterJobtList.clear();
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
  }

  @override
  void initState() {
    super.initState();
    deleteDataFromStorage(StorageKeys.hJobSize);
    deleteDataFromStorage(StorageKeys.hJobSorting);
    deleteDataFromStorage(StorageKeys.hJjobRating);
    deleteDataFromStorage(StorageKeys.hJobPickupType);
    deleteDataFromStorage(StorageKeys.hJobDistance);
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());

    final state = context.read<HelperJobsBloc>().state;
    if (state is GetHelperAllJobsSuccessfull) {
      _filterJobtList = state.activeList;
    }
  }

  Widget searchBar(
    List<HelperActiveJobModel> activeList,
    BuildContext context,
  ) {
    return Column(
      children: [
        const Gap(
          gap: 15,
        ),
        HelperAllJobSearchBarAndButton(
          onChangeText: (text) {
            setState(() {
              _filterJobtList = activeList
                  .where(
                    (contact) => contact.title.toLowerCase().contains(
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
                double.parse(distance.toString()).toStringAsFixed(1);
            final formatedSize = checkSize(size);
            final formatedOrder = checkOrder(order);
            final formatedPackageType = checkPackageType(pickupType);
            final formatedRating = int.parse(
              rating.toString().substring(0, 1),
            );

            sl<HelperJobsBloc>().add(
              GetHelperAllJobsEvent(
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
            deleteDataFromStorage(StorageKeys.hJobSize);
            deleteDataFromStorage(StorageKeys.hJobSorting);
            deleteDataFromStorage(StorageKeys.hJjobRating);
            deleteDataFromStorage(StorageKeys.hJobPickupType);
            deleteDataFromStorage(StorageKeys.hJobDistance);
            _filterJobtList.clear();
            sl<HelperJobsBloc>().add(
              const GetHelperAllJobsEvent(),
            );
            context.pop();
          },
        ),
        const Gap(gap: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        text: 'Open Jobs',
      ),
      body: BlocBuilder<HelperJobsBloc, HelperJobsState>(
        builder: (context, state) {
          var isAllActiveJobsListEmpty = false;
          if (state is GetHelperAllJobsSuccessfull) {
            isAllActiveJobsListEmpty = state.activeList.isEmpty;
          }
          return SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is GetHelperAllJobsInprogress)
                  const Expanded(
                    child: CircularLoader(),
                  ),
                if (state is GetHelperAllJobsSuccessfull)
                  isAllActiveJobsListEmpty
                      ? Column(
                          children: [
                            searchBar(state.activeList, context),
                            const NoJobsWidget(
                              text: 'No Opens Jobs at the moment',
                            ),
                          ],
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              searchBar(state.activeList, context),
                              if (_filterJobtList.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizeHelper.moderateScale(20),
                                    ),
                                    child: RefreshIndicator(
                                      onRefresh: _onrefresh,
                                      child: ListView.builder(
                                        itemCount: _filterJobtList.length,
                                        itemBuilder: (context, index) {
                                          final currentItem =
                                              _filterJobtList[index];
                                          return JobCardWidget(
                                            firstName: currentItem
                                                .neighbourId.firstName,
                                            lastName: currentItem
                                                .neighbourId.lastName,
                                            packageLength: currentItem.packages,
                                            jobStatus: currentItem.status,
                                            stars: currentItem
                                                .neighbourId.helper.rating,
                                            isSelected: true,
                                            image1: currentItem
                                                .neighbourId.imageUrl
                                                .toString(),
                                            image2: allJobSuitcaseIcon,
                                            label:
                                                '''${currentItem.neighbourId.firstName} ${currentItem.neighbourId.lastName}''',
                                            sublabel: currentItem.title,
                                            onViewTap: () async {
                                              final query = Uri(
                                                queryParameters: {
                                                  'jobId': currentItem.id,
                                                },
                                              ).query;
                                              await context.push(
                                                '''${HelperJobDetailPage.routeName}?$query''',
                                              );
                                            },
                                          );
                                        },
                                      ),
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
          );
        },
      ),
    );
  }
}
