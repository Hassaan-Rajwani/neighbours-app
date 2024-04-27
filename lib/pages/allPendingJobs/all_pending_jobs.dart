// ignore_for_file: use_build_context_synchronously, unnecessary_statements, lines_longer_than_80_chars
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Bids/bids.dart';
import 'package:neighbour_app/pages/allPendingJobs/widgets/pending_job.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';

class AllPendingJobsPage extends StatefulWidget {
  const AllPendingJobsPage({super.key});

  static const routeName = '/all-pending-jobs';

  @override
  State<AllPendingJobsPage> createState() => _AllPendingJobsPageState();
}

class _AllPendingJobsPageState extends State<AllPendingJobsPage> {
  @override
  void initState() {
    sl<JobsBloc>().add(
      const GetPendingJobEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: backButtonAppbar(
        context,
        icon: const Icon(Icons.arrow_back),
        text: 'Pending Jobs',
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<JobsBloc, JobsState>(
        builder: (context, jobState) {
          return SafeArea(
            child: Column(
              children: [
                if (jobState is GetPendingJobInprogress)
                  const CircularLoader(height: 80),
                if (jobState is GetPendingJobSuccessfull)
                  if (jobState.pendingList.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeHelper.moderateScale(20),
                            vertical: SizeHelper.moderateScale(20),
                          ),
                          child: Column(
                            children: jobState.pendingList.asMap().entries.map(
                              (entry) {
                                final itemData = entry.value;
                                final index = entry.key;
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final query = Uri(
                                          queryParameters: {
                                            'jobId':
                                                jobState.pendingList[index].id,
                                          },
                                        ).query;
                                        await context.push(
                                          '${BidsPage.routeName}?$query',
                                        );
                                      },
                                      child: PendingJob(
                                        jobLabel: itemData.title,
                                        jobTypeLabel: checkJobTypeFormat(
                                          itemData.type,
                                        ),
                                        pickupLabel: itemData
                                                    .pickupType.length ==
                                                1
                                            ? itemData.pickupType[0].pascalCase
                                            : '''${itemData.pickupType[0].pascalCase} & ${itemData.pickupType[1].pascalCase}''',
                                        sizeLabel: itemData.size[0].pascalCase,
                                        priceLabel: itemData.budget.toString(),
                                        backColor: itemData.bids.isNotEmpty
                                            ? cornflowerBlue
                                            : gallery,
                                        bidprice: itemData.bids.isEmpty
                                            ? 'No Bids'
                                            : '''${itemData.bids.length} ${itemData.bids.length == 1 ? 'Bid' : 'Bids'}''',
                                        bidColor: itemData.bids.isNotEmpty
                                            ? Colors.white
                                            : dustyGray,
                                      ),
                                    ),
                                    const Gap(gap: 10),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    )
                  else
                    const NoJobsWidget(text: 'No Pending Jobs at the moment'),
              ],
            ),
          );
        },
      ),
    );
  }
}
