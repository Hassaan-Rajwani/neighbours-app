// ignore_for_file: deprecated_member_use, avoid_bool_literals_in_conditional_expressions, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AppbarButton extends StatelessWidget {
  const AppbarButton({
    required this.state,
    required this.icon,
    required this.userType,
    super.key,
  });

  final AuthStateUserType state;
  final String icon;
  final String userType;

  @override
  Widget build(BuildContext context) {
    Future<void> getNotifications() async {
      sl<NotificationFeedBloc>().add(
        GetNotificationEvent(
          isNeighbr: userType == 'neighbor',
        ),
      );
    }

    return BlocBuilder<NotificationFeedBloc, NotificationFeedState>(
      builder: (context, notificationState) {
        return InkWell(
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(100),
          ),
          onTap: notificationState is GetNotificationListState
              ? () {
                  sl<AuthBloc>().add(
                    AuthUserTypeEvent(
                      type: userType == 'helper'
                          ? homeScreenType.Helper.name
                          : homeScreenType.Neighbor.name,
                    ),
                  );
                  getNotifications();
                }
              : () {},
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeHelper.moderateScale(12),
              horizontal:
                  SizeHelper.moderateScale(userType != 'helper' ? 23 : 28),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  color: state.userType == homeScreenType.Helper.name &&
                          userType == 'helper'
                      ? Colors.white
                      : state.userType == homeScreenType.Neighbor.name &&
                              userType == 'neighbor'
                          ? Colors.white
                          : codGray,
                  height: SizeHelper.moderateScale(20),
                  width: SizeHelper.moderateScale(20),
                ),
                const Gap(
                  gap: 4,
                  axis: 'x',
                ),
                Text(
                  userType == 'helper'
                      ? homeScreenType.Helper.name
                      : homeScreenType.Neighbor.name,
                  style: TextStyle(
                    fontFamily: nunitoMedium,
                    fontSize: SizeHelper.moderateScale(12),
                    color: state.userType == homeScreenType.Helper.name &&
                            userType == 'helper'
                        ? Colors.white
                        : state.userType == homeScreenType.Neighbor.name &&
                                userType == 'neighbor'
                            ? Colors.white
                            : codGray,
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
