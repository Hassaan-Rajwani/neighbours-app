// ignore_for_file: deprecated_member_use, avoid_bool_literals_in_conditional_expressions, lines_longer_than_80_chars
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/pages/EditProfile/edit_profile.dart';
import 'package:neighbour_app/pages/Home/widgets/appbar_button.dart';
import 'package:neighbour_app/pages/notificationPage/notification_page.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:skeletons/skeletons.dart';

class HomeAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppbar({
    required this.state,
    super.key,
  });

  final AuthStateUserType state;

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
  @override
  Size get preferredSize => Size.fromHeight(SizeHelper.moderateScale(80));
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  void didChangeDependencies() {
    getNotifications();
    super.didChangeDependencies();
  }

  Future<void> getNotifications() async {
    sl<NotificationFeedBloc>().add(
      GetNotificationEvent(
        isNeighbr: widget.state.userType == homeScreenType.Neighbor.name
            ? true
            : false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: SizeHelper.moderateScale(80),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileInitial) {
                    final bytes = state.imageUrl != null
                        ? base64Decode(state.imageUrl!)
                        : null;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            context.push(EditProfilePage.routeName);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                bytes != null ? Colors.transparent : codGray,
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
                                      fontSize: SizeHelper.moderateScale(16),
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    );
                  }
                  return SkeletonItem(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(9, 5, 5, 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    stops: const [0.5, 0.5],
                    colors: [
                      if (widget.state.userType == homeScreenType.Neighbor.name)
                        codGray
                      else
                        Colors.white,
                      if (widget.state.userType == homeScreenType.Neighbor.name)
                        Colors.white
                      else
                        codGray,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppbarButton(
                      state: widget.state,
                      icon: neighbourIcon,
                      userType: 'neighbor',
                    ),
                    AppbarButton(
                      state: widget.state,
                      icon: helperIcon,
                      userType: 'helper',
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<NotificationFeedBloc, NotificationFeedState>(
              builder: (context, state) {
                if (state is GetNotificationListState) {
                  return notificationButton(
                    notifyIcon: state.list.unReadCount != 0,
                  );
                }
                return notificationButton();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationButton({
    bool notifyIcon = false,
  }) {
    return GestureDetector(
      onTap: () {
        final query = Uri(
          queryParameters: {
            'isNeighbr': widget.state.userType == homeScreenType.Neighbor.name
                ? 'true'
                : 'false',
          },
        ).query;
        context.push('${NotificationPage.routeName}?$query');
      },
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            CircleAvatar(
              radius: SizeHelper.moderateScale(20),
              backgroundColor: Colors.white,
              child: Icon(
                notifyIcon
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_none_outlined,
                color: codGray,
              ),
            ),
            if (notifyIcon)
              Positioned(
                right: 12,
                top: 10,
                child: CircleAvatar(
                  radius: SizeHelper.moderateScale(4),
                  backgroundColor: persimmon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
