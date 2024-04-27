import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

PreferredSizeWidget backButtonAppbar(
  BuildContext context, // Pass the BuildContext as a parameter
  {
  Widget? icon,
  String? text,
  Color? backgroundColor,
  Widget? rightSideWidget,
  bool elevation = true,
  VoidCallback? onTap,
  bool? customOntap = false,
}) {
  var toolbarHeight = defaultToolbarHeight; // Default height for Android

  // Check if the platform is iOS
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    toolbarHeight = iosToolbarHeight;
  }

  return AppBar(
    automaticallyImplyLeading: false,
    surfaceTintColor: Colors.white,
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: text == null
        ? 0
        : elevation
            ? 2
            : 0,
    leadingWidth: 60,
    leading: Builder(
      builder: (BuildContext context) {
        if (icon != null) {
          return Container(
            margin: EdgeInsets.only(left: SizeHelper.moderateScale(20)),
            height: SizeHelper.moderateScale(44),
            width: SizeHelper.moderateScale(44),
            decoration: const BoxDecoration(
              color: cornflowerBlue,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: customOntap! ? onTap : context.pop,
              child: icon,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    ),
    title: text == null
        ? Container()
        : Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: interSemibold,
              fontSize: SizeHelper.moderateScale(16),
            ),
          ),
    centerTitle: true,
    shadowColor: backgroundColor,
    actions: [if (rightSideWidget == null) Container() else rightSideWidget],
  );
}

const double defaultToolbarHeight = 80;
const double iosToolbarHeight = 50;
