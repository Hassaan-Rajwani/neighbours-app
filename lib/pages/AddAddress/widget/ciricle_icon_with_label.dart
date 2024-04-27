// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class CircleIconWithLabel extends StatelessWidget {
  const CircleIconWithLabel({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.index,
    super.key,
    this.iconColor = cornflowerBlue,
    this.circleColor = Colors.white,
    this.boxShadowSpreadRadius = 1,
    this.boxShadowColor = mercury,
  });
  final String icon;
  final String label;
  final void Function(int) onTap;
  final Color iconColor;
  final Color circleColor;
  final double boxShadowSpreadRadius;
  final Color boxShadowColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        padding: EdgeInsets.only(right: SizeHelper.moderateScale(25)),
        child: Column(
          children: [
            Container(
              width: SizeHelper.moderateScale(50),
              height: SizeHelper.moderateScale(50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                boxShadow: [
                  BoxShadow(
                    color: boxShadowColor,
                    spreadRadius: boxShadowSpreadRadius,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  color: iconColor,
                ),
              ),
            ),
            const Gap(gap: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: interMedium,
                fontSize: 12,
                color: mineShaft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
