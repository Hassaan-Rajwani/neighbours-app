// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HomeLinkBox extends StatelessWidget {
  const HomeLinkBox({
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
        height: SizeHelper.moderateScale(120),
        width: SizeHelper.moderateScale(240),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cornflowerBlue,
              cornflowerBlue.withOpacity(0.35),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(10),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 5,
              bottom: 10,
              child: SvgPicture.asset(
                icon,
                color: Colors.white.withOpacity(0.2),
                height: SizeHelper.moderateScale(102),
                width: SizeHelper.moderateScale(102),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    height: SizeHelper.moderateScale(30),
                    width: SizeHelper.moderateScale(30),
                    icon,
                    color: Colors.white,
                  ),
                  const Gap(gap: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: nunitoMedium,
                      fontSize: SizeHelper.moderateScale(14),
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
