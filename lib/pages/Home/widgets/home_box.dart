// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HomeBox extends StatelessWidget {
  const HomeBox({
    required this.icon,
    required this.title,
    this.onTap,
    this.changeColor = false,
    super.key,
  });

  final String icon;
  final String title;
  final VoidCallback? onTap;
  final bool changeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: SizeHelper.moderateScale(10),
        ),
        height: SizeHelper.moderateScale(80),
        width: SizeHelper.moderateScale(106),
        decoration: BoxDecoration(
          border: Border.all(
            color: cornflowerBlue,
          ),
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: changeColor ? const Color(0xFF67CA81) : cornflowerBlue,
            ),
            const Gap(gap: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: nunitoMedium,
                fontSize: SizeHelper.moderateScale(12),
                color: codGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
