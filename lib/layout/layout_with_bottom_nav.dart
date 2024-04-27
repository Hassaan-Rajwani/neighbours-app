// ignore_for_file: strict_raw_type, unawaited_futures, inference_failure_on_collection_literal, lines_longer_than_80_chars, constant_identifier_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/AllJobs/helper_new_jobs.dart';
import 'package:neighbour_app/pages/Chat/chats.dart';
import 'package:neighbour_app/pages/Helper/helper.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/Settings/settings.dart';
import 'package:neighbour_app/pages/jobsHistory/jobs_history.dart';
import 'package:neighbour_app/pages/postNewJob/post_new_job.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/bottom_nav_item.dart';
import 'package:neighbour_app/widgets/floating_button.dart';

class LayoutWithBottomNav extends StatefulWidget {
  const LayoutWithBottomNav({
    this.pageIndex = 0,
    super.key,
  });

  final int pageIndex;
  static const routeName = '/layout';

  @override
  State<LayoutWithBottomNav> createState() => _LayoutWithBottomNavState();
}

enum homeScreenType { Neighbor, Helper }

class _LayoutWithBottomNavState extends State<LayoutWithBottomNav>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  bool toggle = false;
  late AnimationController controller;

  List<String> navs = ['Home', 'Helpers', 'Chat', 'Setting'];
  List<String> inActiveIcons = [navHome, navHelp, navChat, navSetting];
  List<String> activeIcons = [
    selectedNavHome,
    selectedNavHelp,
    selectedNavChat,
    selectedNavSetting,
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.pageIndex;
    sl<AddressBloc>().add(GetAddressEvent());
    sl<CardsBloc>().add(GetCardsListEvent());
    controller = BottomSheet.createAnimationController(this);
    controller
      ..duration = Duration.zero
      ..reverseDuration = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthStateUserType) {
      return Scaffold(
        body: bottomTabs[currentIndex],
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButton(
          toggle: toggle,
          onTap: () {
            _buildBottomSheet(context);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: cornflowerBlue,
          unselectedItemColor: inactiveGray,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (int idx) => _onItemTapped(idx, context, authState),
          items: _buildNavList(
            list: navs,
          ),
        ),
      );
    }
    return Container();
  }

  List<BottomNavigationBarItem> _buildNavList({required List<String> list}) {
    return list.asMap().entries.map((e) {
      return BottomNavigationBarItem(
        label: '',
        icon: BottomNavItem(
          currentIndex: currentIndex,
          icon: SvgPicture.asset(
            currentIndex == e.key ? activeIcons[e.key] : inActiveIcons[e.key],
            width: SizeHelper.moderateScale(20),
            height: SizeHelper.moderateScale(20),
          ),
          name: e.value,
          index: e.key,
        ),
      );
    }).toList();
  }

  void _onItemTapped(int index, BuildContext context, AuthStateUserType state) {
    switch (index) {
      case 0:
        setState(() {
          toggle = false;
          currentIndex = 0;
        });
      case 1:
        if (state.userType == homeScreenType.Neighbor.name) {
          setState(() {
            toggle = false;
            currentIndex = 1;
          });
        }
      case 2:
        setState(() {
          toggle = false;
          currentIndex = 2;
        });
      case 3:
        setState(() {
          toggle = false;
          currentIndex = 3;
        });
    }
  }

  Future<void> _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      enableDrag: false,
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      transitionAnimationController: controller,
      builder: (BuildContext context) {
        final authState = context.watch<AuthBloc>().state;
        if (authState is AuthStateUserType) {
          return GestureDetector(
            onTap: context.pop,
            child: Container(
              height: SizeHelper.getDeviceHeight(30),
              width: SizeHelper.getDeviceWidth(100),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeHelper.moderateScale(58),
                      right: SizeHelper.moderateScale(6),
                    ),
                    width: SizeHelper.moderateScale(70),
                    height: SizeHelper.moderateScale(70),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: InkWell(
                      onTap: authState.userType == homeScreenType.Neighbor.name
                          ? () async {
                              context
                                ..pop()
                                ..push(PostNewJobPage.routeName);
                            }
                          : () async {
                              context
                                ..pop()
                                ..push(HelperNewJobsPage.routeName);
                            },
                      child: SvgPicture.asset(newJob),
                    ),
                  ),
                  Container(
                    width: SizeHelper.moderateScale(70),
                    height: SizeHelper.moderateScale(70),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        context
                          ..pop()
                          ..push(JobsHistoryPage.routeName);
                      },
                      child: SvgPicture.asset(openJob),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeHelper.moderateScale(6),
                      top: SizeHelper.moderateScale(58),
                    ),
                    width: SizeHelper.moderateScale(70),
                    height: SizeHelper.moderateScale(70),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        context
                          ..pop()
                          ..push(
                            '${JobsHistoryPage.routeName}?currentTab=Closed Jobs',
                          );
                      },
                      child: SvgPicture.asset(closeJob),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ).whenComplete(() {
      setState(() {
        toggle = false;
      });
    });
  }

  final bottomTabs = [
    const HomePage(),
    const HelperPage(),
    const ChatsPage(),
    const SettingsPage(),
  ];
}
