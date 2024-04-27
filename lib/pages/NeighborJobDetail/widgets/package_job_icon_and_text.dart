// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class PackageJobIconAndTextWidget extends StatelessWidget {
  const PackageJobIconAndTextWidget({
    required this.heading,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    super.key,
  });
  final String heading;
  final String text;
  final String icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            SizeHelper.moderateScale(18),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: SvgPicture.asset(
            icon,
            color: codGray,
            // height: SizeHelper.moderateScale(24),
            width: SizeHelper.moderateScale(
              icon == './assets/svgs/oneTimeIcon.svg' ? 18 : 24,
            ),
          ),
        ),
        const Gap(gap: 15),
        Text(
          heading,
          style: TextStyle(
            fontFamily: interRegular,
            fontSize: SizeHelper.moderateScale(12),
            color: doveGray,
          ),
        ),
        const Gap(gap: 15),
        Text(
          text,
          style: TextStyle(
            fontFamily: interSemibold,
            fontSize: SizeHelper.moderateScale(12),
            color: codGray,
          ),
        ),
      ],
    );
  }
}
