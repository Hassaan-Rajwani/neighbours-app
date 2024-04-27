// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/HelperJobDetail/widgets/helper_bid_accepted.dart';
import 'package:neighbour_app/pages/HelperJobDetail/widgets/neighbor_profile_card.dart';
import 'package:neighbour_app/pages/Home/widgets/how_to_use_card.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/function_models.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_package_info_and_address.dart';
import 'package:neighbour_app/pages/cancelReviewPage/cancel_review_page.dart';
import 'package:neighbour_app/presentation/bloc/getHelperJobById/get_helper_job_by_id_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperPackage/helper_package_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/enum_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/get_help_button.dart';
import 'package:neighbour_app/widgets/job_details_appbar.dart';
import 'package:neighbour_app/widgets/photo_dialog_box.dart';

class HelperJobDetailPage extends StatefulWidget {
  const HelperJobDetailPage({
    required this.helperData,
    super.key,
  });

  final Map<String, dynamic> helperData;
  static const routeName = '/helper-job-details';

  @override
  State<HelperJobDetailPage> createState() => _HelperJobDetailPageState();
}

class _HelperJobDetailPageState extends State<HelperJobDetailPage> {
  @override
  void didChangeDependencies() {
    _onRefresh();
    sl<GetHelperJobByIdBloc>().add(
      GetHelperJobEvent(
        jobId: widget.helperData['jobId'].toString(),
      ),
    );
    super.didChangeDependencies();
  }

  Future<void> _onRefresh() async {
    sl<HelperPackageBloc>().add(
      GetPackageEvent(
        jobId: widget.helperData['jobId'].toString(),
      ),
    );
  }

  void _showAddNewPackageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoDialogBox(
          jobId: widget.helperData['jobId'].toString(),
          onCancelPressed: () {
            context.pop();
          },
        );
      },
    );
  }

  bool isButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetHelperJobByIdBloc, GetHelperJobByIdState>(
      listener: (context, state) async {
        if (state is GetHelperJobByIdSuccessfull &&
            state.job.status == jobStatus.COMPLETED.name &&
            state.job.helperReviewed! == false) {
          final query = Uri(
            queryParameters: {
              'helperName':
                  '''${state.job.neighbourId.firstName} ${state.job.neighbourId.lastName}''',
              'image': state.job.neighbourId.imageUrl.toString(),
              'jobId': state.job.id,
              'firstName': state.job.neighbourId.firstName,
              'lastName': state.job.neighbourId.lastName,
              'isNeighbr': 'false',
            },
          ).query;
          await context.push('${CancelReviewPage.routeName}?$query');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: SizeHelper.screenHeight,
            child: BlocBuilder<HelperPackageBloc, HelperPackageState>(
              builder: (context, state) {
                final packageState = context.watch<HelperPackageBloc>().state;
                final jobByIdState =
                    context.watch<GetHelperJobByIdBloc>().state;
                final profleState = BlocProvider.of<ProfileBloc>(context).state;
                if (jobByIdState is GetHelperJobByIdInprogress) {
                  return const CircularLoader(
                    height: 90,
                  );
                } else if (jobByIdState is GetHelperJobByIdError) {
                  return const Text('Error');
                } else if (jobByIdState is GetHelperJobByIdSuccessfull) {
                  final status = jobByIdState.job.status;
                  return Stack(
                    children: [
                      // MAIN BODY
                      // ========
                      RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Gap(gap: 80),
                              NeighborProfileCardWidget(
                                data: jobByIdState.job,
                              ),
                              const Gap(gap: 20),
                              if (status == 'PENDING_CANCEL')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeHelper.moderateScale(20),
                                  ),
                                  child: HowToUse(
                                    title: jobByIdState.job.raisedBy == 'HELPER'
                                        ? '''Waiting For Cancellation from other Party'''
                                        : '''Other Party Is Waiting For Cancellation''',
                                    textColor: cinnabar,
                                    iconColor: cinnabar,
                                    raiseby:
                                        jobByIdState.job.raisedBy == 'HELPER',
                                  ),
                                ),
                              const Gap(gap: 20),
                              NeighborPackageInfoAndAddress(
                                data: jobByIdState.job,
                              ),
                              if (jobByIdState.job.status == 'DISPUTE' &&
                                  packageState is GetPackageSuccessfull)
                                Column(
                                  children: [
                                    const Gap(gap: 10),
                                    Image.asset(dispute),
                                    const Gap(gap: 10),
                                    Text(
                                      'This job has been Disputed',
                                      style: TextStyle(
                                        fontFamily: urbanistMedium,
                                        color: codGray,
                                        fontSize: SizeHelper.moderateScale(16),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    if (packageState is GetPackageInprogress ||
                                        packageState is CreatePackageInprogress)
                                      const CircularLoader(
                                        height: 20,
                                      ),
                                    if (packageState is GetPackageSuccessfull)
                                      Column(
                                        children: [
                                          addPackageCheck(
                                            ifTrue: Container(),
                                            ifFalse: Column(
                                              children: [
                                                const Gap(gap: 10),
                                                AppButton(
                                                  text: 'Add New Package',
                                                  onPress: () {
                                                    _showAddNewPackageDialog(
                                                      context,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            isNotEmpty:
                                                packageState.package.isNotEmpty,
                                            jobType: jobByIdState.job.type,
                                            numberOfPackages: jobByIdState
                                                .job.numberOfPackage,
                                            packageLength:
                                                packageState.package.length,
                                            status: jobByIdState.job.status,
                                          ),
                                          const Gap(gap: 20),
                                          if (jobByIdState.job.status ==
                                                  'PENDING_CANCEL' ||
                                              jobByIdState.job.status ==
                                                  'CANCELLED')
                                            Container()
                                          else
                                            HelperBidAcceptedWidget(
                                              packageList: packageState.package,
                                              data: jobByIdState.job,
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              if (packageState is GetPackageSuccessfull &&
                                  showButtons(
                                    status: jobByIdState.job.status,
                                  ))
                                const Gap(gap: 60),
                            ],
                          ),
                        ),
                      ),
                      // APPBAR
                      // ======
                      JobDetailsAppbar(
                        onTap: () {
                          final query = Uri(
                            queryParameters: {
                              'firstName':
                                  jobByIdState.job.neighbourId.firstName,
                              'lastName': jobByIdState.job.neighbourId.lastName,
                              'name':
                                  '''${jobByIdState.job.neighbourId.firstName} ${jobByIdState.job.neighbourId.lastName}''',
                              'userId': profleState is ProfileInitial
                                  ? profleState.id
                                  : 0,
                              'helperId': jobByIdState.job.helperId,
                              'image':
                                  '''${jobByIdState.job.neighbourId.imageUrl}''',
                            },
                          ).query;
                          context.push(
                            '${ChatPage.routeName}?$query',
                          );
                        },
                      ),
                      // BUTTON WIDGET
                      // ============
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: ColoredBox(
                          color: Colors.white,
                          child: Column(
                            children: [
                              if (packageState is GetPackageSuccessfull &&
                                  showButtons(
                                    status: jobByIdState.job.status,
                                  ))
                                GetHelpButton(
                                  onTap: () {
                                    outerCancelJobOnTap(
                                      status: jobByIdState.job.status,
                                      context: context,
                                      jobId: jobByIdState.job.id,
                                      isNeighbor: false,
                                      packageLength:
                                          packageState.package.length,
                                      helperData: jobByIdState.job.neighbourId,
                                      raisedBy: jobByIdState.job.raisedBy,
                                      user: userType.HELPER.name,
                                    );
                                  },
                                ),
                              const Gap(gap: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
