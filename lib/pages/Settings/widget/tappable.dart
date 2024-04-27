import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class Tappable extends StatelessWidget {
  const Tappable({
    required this.svgIconPath,
    required this.text,
    required this.onTap,
    super.key,
  });
  final String svgIconPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            SvgPicture.asset(
              svgIconPath,
              width: SizeHelper.moderateScale(24),
              height: SizeHelper.moderateScale(24),
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: SizeHelper.moderateScale(18),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/svgs/goForwardIcon.svg',
              width: SizeHelper.moderateScale(24),
              height: SizeHelper.moderateScale(24),
              color: doveGray,
            ),
          ],
        ),
      ),
    );
  }
}
