import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({
    required this.title,
    required this.iconColor,
    required this.titleColor,
    required this.subTitleColor,
    required this.titleSize,
    required this.subTitleSize,
    this.text = '',
    super.key,
  });
  final String title;
  final Color iconColor;
  final Color titleColor;
  final Color subTitleColor;
  final double titleSize;
  final double subTitleSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              howToUseIcon,
              color: iconColor,
            ),
            const Gap(
              gap: 10,
              axis: 'x',
            ),
            SizedBox(
              width: SizeHelper.getDeviceWidth(70),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontFamily: ralewayBold,
                  fontSize: titleSize,
                ),
              ),
            ),
          ],
        ),
        const Gap(gap: 5),
        Container(
          margin: EdgeInsets.only(left: SizeHelper.moderateScale(35)),
          child: Text(
            text,
            style: TextStyle(
              color: subTitleColor,
              height: 1.5,
              fontFamily: interRegular,
              fontSize: subTitleSize,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
