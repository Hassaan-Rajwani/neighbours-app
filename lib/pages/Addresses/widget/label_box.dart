// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class LabelBox extends StatelessWidget {
  const LabelBox({
    required this.showBar,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.lableColor,
    required this.onTap,
    required this.textColor,
    required this.index,
    required this.iconColor,
    required this.barColor,
    super.key,
  });

  final bool showBar;
  final String label;
  final String icon;
  final void Function(int) onTap;
  final Color bgColor;
  final Color iconColor;
  final Color lableColor;
  final Color textColor;
  final Color barColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        SizeHelper.moderateScale(5),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            SizeHelper.moderateScale(5),
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        child: Row(
          children: [
            if (showBar)
              Column(
                children: [
                  Container(
                    height: 25,
                    width: 1,
                    color: barColor,
                  ),
                  const Gap(
                    gap: 10,
                    axis: 'x',
                  ),
                ],
              ),
            SvgPicture.asset(
              icon,
              color: iconColor,
            ),
            const Gap(
              gap: 6,
              axis: 'x',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: interBold,
                    fontSize: SizeHelper.moderateScale(12),
                    color: lableColor,
                  ),
                ),
                Text(
                  'Set Address',
                  style: TextStyle(
                    fontFamily: interRegular,
                    color: textColor,
                    fontSize: SizeHelper.moderateScale(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
