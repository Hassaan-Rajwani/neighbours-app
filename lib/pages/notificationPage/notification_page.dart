import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/allPendingJobs/all_pending_jobs.dart';
import 'package:neighbour_app/pages/notificationPage/component/notification_container.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    required this.isNeighbr,
    super.key,
  });

  final bool isNeighbr;

  static const routeName = '/notification-page';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> getNotifications() async {
    sl<NotificationFeedBloc>().add(
      GetNotificationEvent(
        isNeighbr: widget.isNeighbr,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await getNotifications();
        return true;
      },
      child: Scaffold(
        appBar: backButtonAppbar(
          context,
          icon: const Icon(Icons.arrow_back),
          backgroundColor: Colors.white,
          text: 'Notifications',
          elevation: false,
          customOntap: true,
          onTap: () {
            getNotifications();
            context.pop();
          },
        ),
        body: BlocBuilder<NotificationFeedBloc, NotificationFeedState>(
          builder: (context, state) {
            if (state is GetNotificationListState) {
              final reversedList =
                  List.of(state.list.notificationList.reversed);
              return Container(
                margin: EdgeInsets.only(
                  top: SizeHelper.moderateScale(10),
                ),
                child: state.list.notificationList.isEmpty
                    ? SizedBox(
                        height: SizeHelper.getDeviceHeight(80),
                        child: Center(
                          child: SvgPicture.asset(noNotificationIcon),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reversedList.length,
                        itemBuilder: (context, index) {
                          final originalIndex =
                              state.list.notificationList.length - 1 - index;
                          final notificationId =
                              state.list.notificationList[originalIndex].id;
                          return NotificationContainer(
                            data: reversedList[index],
                            onDelete: (context) {
                              sl<NotificationFeedBloc>().add(
                                DeleteNotification(
                                  isNeighbr: widget.isNeighbr,
                                  notificationId: notificationId,
                                ),
                              );
                              setState(() {
                                state.list.notificationList
                                    .removeAt(originalIndex);
                              });
                            },
                            onTap: () {
                              sl<NotificationFeedBloc>().add(
                                MarkAsReadNotification(
                                  isNeighbr: widget.isNeighbr,
                                  notificationId: notificationId,
                                ),
                              );
                              final query = Uri(
                                queryParameters: {
                                  'jobId': state
                                      .list
                                      .notificationList[originalIndex]
                                      .route
                                      .jobId,
                                },
                              ).query;
                              if (state.list.notificationList[originalIndex]
                                      .route.url ==
                                  '/bid-page') {
                                context.push(AllPendingJobsPage.routeName);
                              } else {
                                context.push(
                                  '''${state.list.notificationList[originalIndex].route.url}?$query''',
                                );
                              }
                              setState(() {
                                state.list.notificationList[originalIndex]
                                    .isRead = true;
                              });
                            },
                          );
                        },
                      ),
              );
            }
            return const CircularLoader();
          },
        ),
      ),
    );
  }
}
