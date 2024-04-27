import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Home/widgets/neighbors_dashoard_loader.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/home_do_more_widget.dart';
import 'package:neighbour_app/widgets/home_heading_text.dart';
import 'package:neighbour_app/widgets/home_nearby_banner.dart';
import 'package:skeletons/skeletons.dart';

class NewHomeHelper extends StatelessWidget {
  const NewHomeHelper({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> getNotifications() async {
      sl<NotificationFeedBloc>().add(
        const GetNotificationEvent(
          isNeighbr: false,
        ),
      );
    }

    final data = homeData(isNeighbr: false);
    final dataLink = homeDataLink();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getNotifications,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: SizeHelper.moderateScale(20),
            ),
            alignment: Alignment.topCenter,
            child: BlocBuilder<JobsBloc, JobsState>(
              builder: (context, state) {
                if (state is GetPendingJobInprogress) {
                  return const SkeletonItem(
                    child: DashboardLoaderBoxes(isNeighbr: false),
                  );
                }
                return Column(
                  children: [
                    const HomeNearbyBanner(isHelper: true),
                    const Gap(gap: 30),
                    const HomeHeadingText(text: 'Dashboard'),
                    const Gap(gap: 10),
                    HomeBoxesCall(data: data),
                    const Gap(gap: 30),
                    const HomeHeadingText(text: 'Do More With Neighbrs'),
                    const Gap(gap: 10),
                    HomeBoxesCall(data: dataLink, isDashboard: false),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
