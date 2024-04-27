// ignore_for_file: use_build_context_synchronously, unused_local_variable, lines_longer_than_80_chars
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/EditProfile/edit_profile.dart';
import 'package:neighbour_app/pages/Helper/widget/HelpersCard.dart';
import 'package:neighbour_app/pages/Helper/widget/helper_searchbar.dart';
import 'package:neighbour_app/pages/helperProfile/helper_profile.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobHistoryAndReviews/job_history_and_reviews_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/no_jobs_widget.dart';

class HelperPage extends StatefulWidget {
  const HelperPage({super.key});

  static String routeName = '/helpers';

  @override
  State<HelperPage> createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  List<AllHelpersModel> _filterHelpertList = [];
  String neighborsUserId = '0';
  String currentTabbar = 'Helpers';
  String currentTabbar1 = 'Neighbors';

  @override
  void initState() {
    super.initState();
    deleteDataFromStorage(StorageKeys.helperNeighbrDistance);
    deleteDataFromStorage(StorageKeys.helperNeighbrRating);
    sl<AllHelperBloc>().add(GetAllHelpersEvent(miles: 0, rating: 0));
    getListFilter();
  }

  @override
  void didChangeDependencies() {
    getListFilter();
    super.didChangeDependencies();
  }

  void getListFilter() {
    final state = context.read<AllHelperBloc>().state;
    if (state is AllHelperStateSuccessful) {
      setState(() {
        _filterHelpertList = state.list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    return BlocListener<AllHelperBloc, AllHelperState>(
      listener: (context, state) {
        didChangeDependencies();
      },
      child: BlocBuilder<AllHelperBloc, AllHelperState>(
        builder: (context, state) {
          if (state is GetHelperInProgress) {
            return const CircularLoader();
          }
          if (state is AllHelperStateSuccessful) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(gap: 15),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is GetProfileInProgress) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeHelper.moderateScale(25),
                              horizontal: SizeHelper.moderateScale(15),
                            ),
                            height: SizeHelper.moderateScale(20),
                            width: SizeHelper.moderateScale(20),
                            child: const CircularProgressIndicator(),
                          );
                        }
                        if (state is ProfileInitial) {
                          final bytes = state.imageUrl != null
                              ? base64Decode(state.imageUrl!)
                              : null;
                          neighborsUserId = state.id;
                          return InkWell(
                            onTap: () {
                              context.push(EditProfilePage.routeName);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeHelper.moderateScale(15),
                              ),
                              child: CircleAvatar(
                                backgroundColor: bytes != null
                                    ? Colors.transparent
                                    : codGray,
                                backgroundImage:
                                    bytes != null ? MemoryImage(bytes) : null,
                                radius: SizeHelper.moderateScale(20),
                                child: bytes == null
                                    ? Text(
                                        getInitials(
                                          firstName: state.firstName,
                                          lastName: state.lastName,
                                        ),
                                        style: TextStyle(
                                          fontFamily: ralewayBold,
                                          fontSize:
                                              SizeHelper.moderateScale(16),
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    if (authState is AuthStateUserType)
                      Expanded(
                        child: Column(
                          children: [
                            const Gap(gap: 25),
                            HelpersSearchBarAndButton(
                              onChangeText: (text) {
                                setState(() {
                                  _filterHelpertList = state.list
                                      .where(
                                        (contact) =>
                                            '''${contact.fisrtName} ${contact.lastName}'''
                                                .toLowerCase()
                                                .contains(
                                                  text.toLowerCase(),
                                                ),
                                      )
                                      .toList();
                                });
                              },
                              label: authState.userType ==
                                      homeScreenType.Neighbor.name
                                  ? 'Search for Helpers'
                                  : 'Search for Neighbors',
                              onTap: (rating, distance) {
                                final formatedRating = int.parse(
                                  rating.toString().substring(0, 1),
                                );
                                final formatedMiles = int.parse(
                                  distance.toString().substring(0, 1),
                                );
                                sl<AllHelperBloc>().add(
                                  GetAllHelpersEvent(
                                    miles: formatedMiles,
                                    rating: formatedRating,
                                  ),
                                );
                                context.pop();
                              },
                              onReset: () async {
                                await Future.wait([
                                  deleteDataFromStorage(
                                    StorageKeys.helperNeighbrDistance,
                                  ),
                                  deleteDataFromStorage(
                                    StorageKeys.helperNeighbrRating,
                                  ),
                                ]);
                                sl<AllHelperBloc>().add(
                                  GetAllHelpersEvent(miles: 0, rating: 0),
                                );
                                context.pop();
                              },
                            ),
                            const Gap(gap: 25),
                            if (_filterHelpertList.isNotEmpty)
                              Expanded(
                                child: authState.userType ==
                                        homeScreenType.Neighbor.name
                                    ? currentTabbar == 'Helpers' ||
                                            currentTabbar == 'Neighbors'
                                        ? ListView.builder(
                                            itemCount:
                                                _filterHelpertList.length,
                                            itemBuilder: (context, index) {
                                              final currentItem =
                                                  _filterHelpertList[index];
                                              final helperImage = currentItem
                                                  .imageUrl
                                                  .toString();
                                              return GestureDetector(
                                                onTap: () async {
                                                  final token =
                                                      await getDataFromStorage(
                                                    StorageKeys.userToken,
                                                  );
                                                  final name =
                                                      '''${currentItem.fisrtName} ${currentItem.lastName}''';
                                                  final rating = double.parse(
                                                    state.list[index].helperInfo
                                                        .rating
                                                        .toStringAsFixed(1),
                                                  ).toString();
                                                  final jobsDone = state
                                                      .list[index]
                                                      .helperInfo
                                                      .jobDone
                                                      .toString();
                                                  final userId = currentItem.id;
                                                  final helperImage =
                                                      currentItem.imageUrl
                                                          .toString();
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'firstName':
                                                          currentItem.fisrtName,
                                                      'lastName':
                                                          currentItem.lastName,
                                                      'name': name,
                                                      'rating': rating,
                                                      'jobsDone': jobsDone,
                                                      'userId': userId,
                                                      'image': helperImage,
                                                      'isNeighbr': 'false',
                                                      'neighborsId':
                                                          neighborsUserId,
                                                    },
                                                  ).query;
                                                  sl<JobHistoryAndReviewsBloc>()
                                                      .add(
                                                    GetJobHistoryAndReviewsEvent(
                                                      userId: userId,
                                                      isNeighbr: false,
                                                    ),
                                                  );
                                                  await context.push(
                                                    '''${HelperProfilePage.routeName}?$query''',
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: SizeHelper
                                                        .moderateScale(
                                                      _filterHelpertList
                                                                      .length -
                                                                  1 ==
                                                              index
                                                          ? 30
                                                          : 0,
                                                    ),
                                                  ),
                                                  child: HelpersCard(
                                                    data: currentItem,
                                                    onTap: () {
                                                      final query = Uri(
                                                        queryParameters: {
                                                          'name': currentItem
                                                              .fisrtName,
                                                          'firstName':
                                                              currentItem
                                                                  .fisrtName,
                                                          'lastName':
                                                              currentItem
                                                                  .lastName,
                                                          'userId':
                                                              neighborsUserId,
                                                          'helperId':
                                                              currentItem.id,
                                                          'image': helperImage,
                                                        },
                                                      ).query;
                                                      context.push(
                                                        '''${ChatPage.routeName}?$query''',
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container()
                                    : currentTabbar1 == 'Helpers' ||
                                            currentTabbar1 == 'Neighbors'
                                        ? ListView.builder(
                                            itemCount:
                                                _filterHelpertList.length,
                                            itemBuilder: (context, index) {
                                              final currentItem =
                                                  _filterHelpertList[index];
                                              final helperImage = currentItem
                                                  .imageUrl
                                                  .toString();
                                              return GestureDetector(
                                                onTap: () async {
                                                  final token =
                                                      await getDataFromStorage(
                                                    StorageKeys.userToken,
                                                  );
                                                  final name =
                                                      '''${currentItem.fisrtName} ${currentItem.lastName}''';
                                                  final rating = double.parse(
                                                    state.list[index].helperInfo
                                                        .rating
                                                        .toStringAsFixed(1),
                                                  ).toString();
                                                  final jobsDone = state
                                                      .list[index]
                                                      .helperInfo
                                                      .jobDone
                                                      .toString();
                                                  final userId = currentItem.id;
                                                  final helperImage =
                                                      currentItem.imageUrl
                                                          .toString();
                                                  final query = Uri(
                                                    queryParameters: {
                                                      'firstName':
                                                          currentItem.fisrtName,
                                                      'lastName':
                                                          currentItem.lastName,
                                                      'name': name,
                                                      'rating': rating,
                                                      'jobsDone': jobsDone,
                                                      'userId': userId,
                                                      'image': helperImage,
                                                      'isNeighbr': 'true',
                                                      'neighborsId':
                                                          neighborsUserId,
                                                    },
                                                  ).query;
                                                  sl<JobHistoryAndReviewsBloc>()
                                                      .add(
                                                    GetJobHistoryAndReviewsEvent(
                                                      userId: userId,
                                                      isNeighbr: true,
                                                    ),
                                                  );
                                                  await context.push(
                                                    '''${HelperProfilePage.routeName}?$query''',
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: SizeHelper
                                                        .moderateScale(
                                                      _filterHelpertList
                                                                      .length -
                                                                  1 ==
                                                              index
                                                          ? 30
                                                          : 0,
                                                    ),
                                                  ),
                                                  child: HelpersCard(
                                                    data: currentItem,
                                                    onTap: () {
                                                      final query = Uri(
                                                        queryParameters: {
                                                          'name': currentItem
                                                              .fisrtName,
                                                          'firstName':
                                                              currentItem
                                                                  .fisrtName,
                                                          'lastName':
                                                              currentItem
                                                                  .lastName,
                                                          'userId':
                                                              neighborsUserId,
                                                          'helperId':
                                                              currentItem.id,
                                                          'image': helperImage,
                                                        },
                                                      ).query;
                                                      context.push(
                                                        '''${ChatPage.routeName}?$query''',
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(),
                              )
                            else
                              const NoJobsWidget(
                                gap: 120,
                                text: 'Not Available',
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
