// ignore_for_file: inference_failure_on_function_invocation, unused_local_variable, prefer_final_locals, omit_local_variable_types, unnecessary_statements, lines_longer_than_80_chars, unused_element, avoid_bool_literals_in_conditional_expressions, flutter_style_todos, unnecessary_type_check, avoid_dynamic_calls
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/mappers/favorite/add_favorite.dart';
import 'package:neighbour_app/data/models/favorite.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/helper_profile_card_widget.dart';
import 'package:neighbour_app/pages/helperProfile/widgets/delivery_details_card.dart';
import 'package:neighbour_app/pages/helperProfile/widgets/reviews_details_card.dart';
import 'package:neighbour_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAnotherUser/get_another_user_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobHistoryAndReviews/job_history_and_reviews_bloc.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/job_details_appbar.dart';
import 'package:neighbour_app/widgets/tab_bar_button.dart';

class HelperProfilePage extends StatefulWidget {
  const HelperProfilePage({
    required this.helperdata,
    super.key,
  });

  static const routeName = '/helper-profile';
  final Map<String, dynamic> helperdata;

  @override
  State<HelperProfilePage> createState() => _HelperProfilePageState();
}

class _HelperProfilePageState extends State<HelperProfilePage> {
  final tabLabels = ['Deliveries Received', 'Reviews'];
  String currentTab = 'Deliveries Received';

  Future<void> addToFavoritesList({required String userId}) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    sl<FavoriteBloc>().add(
      AddFavoriteEvent(
        body: AddFavorite(helperId: userId),
        token: token.toString(),
      ),
    );
  }

  Future<void> _deleteFromFavorite(String favoriteId) async {
    sl<FavoriteBloc>().add(
      DeleteFavoriteEvent(
        favoriteID: favoriteId,
      ),
    );
  }

  List<FavoriteModel> favoriteList = [];

  String favoriteId = '';

  @override
  void initState() {
    sl<GetAnotherUserBloc>().add(
      GetAnotherUser(
        helperId: widget.helperdata['userId'].toString(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final anotherUserState = context.watch<GetAnotherUserBloc>().state;
    if (anotherUserState is GetAnotherUserSuccessfull) {
      final helperId = anotherUserState.helperId.userId;
      bool isUserFavorite = anotherUserState.helperId.isFavorite;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              JobDetailsAppbar(
                heading: 'Profile',
                onTap: () {
                  final query = Uri(
                    queryParameters: {
                      'firstName': widget.helperdata['firstName'],
                      'lastName': widget.helperdata['lastName'],
                      'name': widget.helperdata['name'],
                      'userId': widget.helperdata['neighborsId'],
                      'helperId': widget.helperdata['userId'],
                      'image': widget.helperdata['image'],
                    },
                  ).query;
                  context.push(
                    '${ChatPage.routeName}?$query',
                  );
                },
              ),
              HelperProfileCardWidget(
                jobData: anotherUserState.helperId,
                isFavorite: isUserFavorite,
                onFavoriteTap: () async {
                  setState(() {
                    anotherUserState.helperId.isFavorite =
                        !anotherUserState.helperId.isFavorite;
                  });
                  if (isUserFavorite == false) {
                    await addToFavoritesList(
                      userId: helperId,
                    );
                  } else {
                    if (anotherUserState.helperId.favorite != null) {
                      await _deleteFromFavorite(
                        anotherUserState.helperId.favorite!.id,
                      );
                    }
                  }
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(gap: 10),
                      BlocBuilder<JobHistoryAndReviewsBloc,
                          JobHistoryAndReviewsState>(
                        builder: (context, state) {
                          var isJobHistoryEmpty = false;
                          var isReviewListEmpty = false;
                          if (state is GetJobHistoryAndReviewsInProgress) {
                            return const CircularLoader(
                              height: 70,
                            );
                          }
                          if (state is GetJobHistoryAndReviewsSuccessfull) {
                            isJobHistoryEmpty = state.jobHistoryList.isEmpty;
                            isReviewListEmpty = state.reviewsList.isEmpty;
                            if (currentTab == 'Deliveries Received') {
                              return Column(
                                children: [
                                  const Gap(gap: 15),
                                  CustomTabBar(
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
                                  const Gap(gap: 20),
                                  Column(
                                    mainAxisAlignment: isJobHistoryEmpty
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start,
                                    children: isJobHistoryEmpty
                                        ? [
                                            const Center(
                                              child: Text(
                                                '''This user has not completed any job yet.''',
                                              ),
                                            ),
                                          ]
                                        : state.jobHistoryList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final jobHistoryData = entry.value;
                                            return DeliveryDetailsCard(
                                              orderId: jobHistoryData.id,
                                              status: jobStatusCheck(
                                                status: jobHistoryData.status,
                                              ),
                                              dateAndTime: jobHistoryData
                                                  .createdAt
                                                  .toString(),
                                              title: jobHistoryData.title,
                                              amount: jobHistoryData.amount!.toDouble(),
                                              description:
                                                  jobHistoryData.description,
                                            );
                                          }).toList(),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  const Gap(gap: 15),
                                  CustomTabBar(
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
                                  const Gap(gap: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: isReviewListEmpty
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start,
                                    children: isReviewListEmpty
                                        ? [
                                            const Center(
                                              child: Text('No Reviews'),
                                            ),
                                          ]
                                        : state.reviewsList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final reviewData = entry.value;
                                            final userName = widget.helperdata[
                                                        'isNeighbr'] ==
                                                    'false'
                                                ? '''${reviewData.neighbor['first_name']} ${reviewData.neighbor['last_name']}'''
                                                : '''${reviewData.helper['first_name']} ${reviewData.helper['last_name']}''';
                                            return ReviewsDetalsCard(
                                              name: userName,
                                              dateAndTime: reviewData.createdAt
                                                  .toString(),
                                              rate: reviewData.rate.toString(),
                                              review: reviewData.detail,
                                            );
                                          }).toList(),
                                  ),
                                ],
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const CircularLoader();
    }
  }
}
