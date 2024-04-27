import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/pages/HelperJobDetail/helper_job_detail.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/neighbor_job_detail.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/helper_job_history_card.dart';
import 'package:neighbour_app/widgets/job_history_card.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';
import 'package:neighbour_app/widgets/tab_bar_button.dart';

class JobsHistoryPage extends StatefulWidget {
  const JobsHistoryPage({
    required this.currentTab,
    super.key,
  });
  final String currentTab;

  static const routeName = '/jobs-history';

  @override
  State<JobsHistoryPage> createState() => _JobsHistoryPageState();
}

class _JobsHistoryPageState extends State<JobsHistoryPage> {
  final tabLabels = ['Active Jobs', 'Closed Jobs'];
  String currentTab = 'Active Jobs';

  @override
  void initState() {
    super.initState();
    sl<JobsBloc>().add(
      const GetPendingJobEvent(),
    );
    sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent());
    initFunc();
  }

  void initFunc() {
    setState(() {
      currentTab = widget.currentTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    if (state is AuthStateUserType) {
      final jobState = state.userType == homeScreenType.Neighbor.name
          ? context.watch<JobsBloc>().state
          : context.watch<HelperJobsBloc>().state;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: backButtonAppbar(
          context,
          icon: const Icon(Icons.arrow_back),
          backgroundColor: Colors.white,
          text: 'Jobs History',
        ),
        body: Column(
          children: [
            const Gap(gap: 35),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(20),
              ),
              child: CustomTabBar(
                tabLabels: tabLabels,
                initialTab: currentTab,
                onTap: (text) {
                  setState(() {
                    if (text != null) {
                      currentTab = text;
                    }
                  });
                },
              ),
            ),
            const Gap(gap: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(SizeHelper.moderateScale(15)),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
                child: currentTab == 'Active Jobs'
                    ? SingleChildScrollView(
                        child: state.userType == homeScreenType.Neighbor.name
                            // Neighbor Active Jobs
                            ? Column(
                                children: [
                                  if (jobState is GetPendingJobInprogress)
                                    const CircularLoader(height: 60),
                                  if (jobState is GetPendingJobSuccessfull)
                                    jobState.activeList.isEmpty
                                        ? const NoJobsWidget(
                                            gap: 120,
                                            text: 'No Job availabe',
                                          )
                                        : Column(
                                            children: jobState.activeList
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final activejobData = entry.value;
                                              return JobHistoryCard(
                                                jobData: activejobData,
                                                onTap: () {
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'jobId': activejobData.id,
                                                    },
                                                  ).query;
                                                  context.push(
                                                    '''${NeighborJobDetailPage.routeName}?$query''',
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                ],
                              )
                            // Helper Active Jobs n
                            : Column(
                                children: [
                                  if (jobState is GetHelperAllJobsInprogress)
                                    const CircularLoader(height: 60),
                                  if (jobState is GetHelperAllJobsSuccessfull)
                                    jobState.activeList.isEmpty
                                        ? const NoJobsWidget(
                                            gap: 120,
                                            text: 'No Job availabe',
                                          )
                                        : Column(
                                            children: jobState.activeList
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final activejobData = entry.value;
                                              return HelperJobHistoryCard(
                                                jobData: activejobData,
                                                onTap: () {
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'jobId': activejobData.id,
                                                    },
                                                  ).query;
                                                  context.push(
                                                    '''${HelperJobDetailPage.routeName}?$query''',
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                ],
                              ),
                      )
                    : SingleChildScrollView(
                        child: state.userType == homeScreenType.Neighbor.name
                            // Neighbor Closed Jobs
                            ? Column(
                                children: [
                                  if (jobState is GetPendingJobInprogress)
                                    const CircularLoader(height: 60),
                                  if (jobState is GetPendingJobSuccessfull)
                                    jobState.closeList.isEmpty
                                        ? const NoJobsWidget(
                                            gap: 120,
                                            text: 'No Job availabe',
                                          )
                                        : Column(
                                            children: jobState.closeList
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final closejobData = entry.value;
                                              return JobHistoryCard(
                                                jobData: closejobData,
                                                onTap: () {
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'jobId': closejobData.id,
                                                    },
                                                  ).query;
                                                  context.push(
                                                    '''${NeighborJobDetailPage.routeName}?$query''',
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                ],
                              )
                            // Helper Closed Jobs
                            : Column(
                                children: [
                                  if (jobState is GetHelperAllJobsInprogress)
                                    const CircularLoader(height: 60),
                                  if (jobState is GetHelperAllJobsSuccessfull)
                                    jobState.closeList.isEmpty
                                        ? const NoJobsWidget(
                                            gap: 120,
                                            text: 'No Job availabe',
                                          )
                                        : Column(
                                            children: jobState.closeList
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final closejobData = entry.value;
                                              return HelperJobHistoryCard(
                                                jobData: closejobData,
                                                onTap: () {
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'jobId': closejobData.id,
                                                    },
                                                  ).query;
                                                  context.push(
                                                    '''${HelperJobDetailPage.routeName}?$query''',
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                ],
                              ),
                      ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
