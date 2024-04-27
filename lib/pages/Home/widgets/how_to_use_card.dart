import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_info.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({
    required this.title,
    required this.textColor,
    required this.iconColor,
    this.raiseby = true,
    super.key,
  });

  final String title;
  final Color textColor;
  final Color iconColor;
  final bool? raiseby;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
        vertical: SizeHelper.moderateScale(15),
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: orangeWhite,
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      child: SizedBox(
        width: SizeHelper.getDeviceWidth(40),
        child: AppInfoWidget(
          iconColor: iconColor,
          title: title,
          titleColor: textColor,
          subTitleColor: doveGray,
          titleSize: SizeHelper.moderateScale(14),
          subTitleSize: SizeHelper.moderateScale(12),
          text: raiseby!
              ? '''We are currently waiting for the other party to accept the cancellation on their end. We wll inform you when they provide an update.'''
              : '''We are currently waiting for you to accept the cancellation on your end. We will inform them when you provide an update.''',
        ),
      ),
    );
  }
}
