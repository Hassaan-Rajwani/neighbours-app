import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/data/models/favorite.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/Home/widgets/how_to_use_card.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/function_models.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/helper_profile_card_widget.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_accepted_bid.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_package_info_and_address.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/neighbor_give_rating.dart';
import 'package:neighbour_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getById/get_by_id_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/neighborsPackages/neighbors_packages_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/enum_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/get_help_button.dart';
import 'package:neighbour_app/widgets/job_details_appbar.dart';

class NeighborJobDetailPage extends StatefulWidget {
  const NeighborJobDetailPage({
    required this.activeItem,
    super.key,
  });

  final Map<String, dynamic> activeItem;

  static const routeName = '/neighbor-job-details';

  @override
  State<NeighborJobDetailPage> createState() => _NeighborJobDetailPageState();
}

class _NeighborJobDetailPageState extends State<NeighborJobDetailPage> {
  List<NeighborsPackageModel> packageDataList = [];
  bool isButton = false;

  Future<void> addToFavoritesList({required String helperId}) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    sl<FavoriteBloc>().add(
      AddFavoriteEvent(
        body: AddFavorite(helperId: helperId),
        token: token.toString(),
      ),
    );
  }

  @override
  void initState() {
    _onRefresh();
    sl<GetByIdBloc>().add(
      GetJobByIdEvent(
        jobId: widget.activeItem['jobId'].toString(),
      ),
    );
    super.initState();
  }

  Future<void> _onRefresh() async {
    sl<NeighborsPackagesBloc>().add(
      GetNeighborsPackage(
        jobId: widget.activeItem['jobId'].toString(),
      ),
    );
  }

  List<FavoriteModel> favoriteList = [];

  String favoriteId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<JobsBloc, JobsState>(
          builder: (context, state) {
            final packageState = context.watch<NeighborsPackagesBloc>().state;
            final jobByIdState = context.watch<GetByIdBloc>().state;
            final profleState = BlocProvider.of<ProfileBloc>(context).state;
            if (jobByIdState is GetJobByIdSuccessfull) {
              final helperId = jobByIdState.job.helperId != null
                  ? jobByIdState.job.helperId!.id
                  : '0';
              final isUserFavorite = jobByIdState.job.isFavorite;
              final status = jobByIdState.job.status;
              if (packageState is GetNeighborsSuccessfull) {
                packageDataList = packageState.packageData;
                final data = areAllPackagesConfirmed(
                  packageState.packageData,
                );
                isButton = data;
              }
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
                          if (state is GetPendingJobSuccessfull)
                            if (helperId != '0')
                              HelperProfileCardWidget(
                                isFavorite: isUserFavorite,
                                jobData: jobByIdState.job.helperId,
                                onFavoriteTap: () {
                                  if (isUserFavorite == false) {
                                    addToFavoritesList(helperId: helperId);
                                    setState(() {
                                      jobByIdState.job.isFavorite = true;
                                    });
                                  } else {
                                    if (jobByIdState.job.favorite != null) {
                                      sl<FavoriteBloc>().add(
                                        DeleteFavoriteEvent(
                                          favoriteID:
                                              jobByIdState.job.favorite!.id,
                                        ),
                                      );
                                    }
                                    setState(() {
                                      jobByIdState.job.isFavorite = false;
                                    });
                                  }
                                },
                              ),
                          const Gap(gap: 20),
                          if (status == 'PENDING_CANCEL')
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeHelper.moderateScale(20),
                              ),
                              child: HowToUse(
                                title: jobByIdState.job.raisedBy == 'NEIGHBOUR'
                                    ? '''Waiting For Cancellation from other Party'''
                                    : '''Other Party Is Waiting For Cancellation''',
                                textColor: cinnabar,
                                iconColor: cinnabar,
                                raiseby:
                                    jobByIdState.job.raisedBy == 'NEIGHBOUR',
                              ),
                            )
                          else
                            Container(),
                          const Gap(gap: 20),

                          //job details
                          if (state is GetPendingJobSuccessfull)
                            NeighborPackageInfoAndAddress(
                              data: jobByIdState.job,
                            ),
                          if (packageState is GetNeighborsPackageInProgress ||
                              packageState is UpdateNeighborsPackageInProgress)
                            Container(
                              padding: EdgeInsets.all(
                                SizeHelper.moderateScale(50),
                              ),
                              child: const CircularProgressIndicator(),
                            ),
                          if (jobByIdState.job.status == 'DISPUTE' &&
                              packageState is GetNeighborsSuccessfull)
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
                                const Gap(gap: 30),
                              ],
                            )
                          else if (packageState is GetNeighborsSuccessfull)
                            jobByIdState.job.status ==
                                        jobStatus.PENDING_CANCEL.name ||
                                    jobByIdState.job.status ==
                                        jobStatus.CANCELLED.name
                                ? Container()
                                : NeighborAcceptedBidWidget(
                                    packageData: packageState.packageData,
                                    data: jobByIdState.job,
                                  ),
                          if (packageState is GetNeighborsSuccessfull &&
                              showButtons(
                                status: jobByIdState.job.status,
                              ))
                            const Gap(gap: 120),
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
                          'name':
                              '''${jobByIdState.job.helperId!.firstName} ${jobByIdState.job.helperId!.lastName}''',
                          'firstName':
                                  jobByIdState.job.helperId!.firstName,
                              'lastName': jobByIdState.job.helperId!.lastName,
                          'userId': profleState is ProfileInitial
                              ? profleState.id
                              : 0,
                          'helperId': jobByIdState.job.helperId!.id,
                          'image': jobByIdState.job.helperId!.imageUrl,
                        },
                      ).query;
                      context.push(
                        '${ChatPage.routeName}?$query',
                      );
                    },
                  ),
                  // BUTTON WIDGET
                  // ============
                  if (packageState is GetNeighborsSuccessfull &&
                      showButtons(
                        status: jobByIdState.job.status,
                      ))
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: ColoredBox(
                        color: polar,
                        child: Column(
                          children: [
                            const Gap(gap: 10),
                            AppButton(
                              onPress: statusAndPackagesCheck(
                                ifTrue: () {},
                                ifFalse: () {
                                  context.pop();
                                  final query = Uri(
                                    queryParameters: {
                                      'firstName':
                                          jobByIdState.job.helperId!.firstName,
                                      'lastName':
                                          jobByIdState.job.helperId!.lastName,
                                      'helperName':
                                          '''${jobByIdState.job.helperId!.firstName} ${jobByIdState.job.helperId!.lastName}''',
                                      'jobId': jobByIdState.job.id,
                                      'image':
                                          jobByIdState.job.helperId!.imageUrl,
                                    },
                                  ).query;
                                  context.push(
                                    '''${NeighborGiveRatingPage.routeName}?$query''',
                                  );
                                },
                                button: isButton,
                                numberOfPackages: int.parse(
                                  jobByIdState.job.numberOfPackage.toString(),
                                ),
                                status: jobByIdState.job.status,
                                packageLength: packageState.packageData.length,
                              ) as VoidCallback,
                              backgroundColor: statusAndPackagesCheck(
                                status: jobByIdState.job.status,
                                ifTrue: inactiveGray,
                                ifFalse: cornflowerBlue,
                                button: isButton,
                                numberOfPackages: int.parse(
                                  jobByIdState.job.numberOfPackage.toString(),
                                ),
                                packageLength: packageState.packageData.length,
                              ) as Color,
                              text: 'Complete Job',
                            ),
                            const Gap(gap: 10),
                            GetHelpButton(
                              onTap: () {
                                outerCancelJobOnTap(
                                  status: jobByIdState.job.status,
                                  context: context,
                                  jobId: jobByIdState.job.id,
                                  isNeighbor: true,
                                  packageLength:
                                      packageState.packageData.length,
                                  helperData: jobByIdState.job.helperId,
                                  raisedBy: jobByIdState.job.raisedBy,
                                  user: userType.NEIGHBOUR.name,
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
            return const CircularLoader();
          },
        ),
      ),
    );
  }
}
