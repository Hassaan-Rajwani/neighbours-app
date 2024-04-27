import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    required this.title,
    required this.subTitle,
    required this.subTitleSize,
    super.key,
    this.subTitleColor = silver,
    this.isBorder = true,
    this.isBold = false,
  });
  final String title;
  final String subTitle;
  final Color subTitleColor;
  final double subTitleSize;
  final bool isBorder;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          right: isBorder == true
              ? const BorderSide(color: silverColor)
              : BorderSide.none,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: ralewayBold,
              fontSize: SizeHelper.moderateScale(14),
              color: codGray,
            ),
          ),
          const Gap(gap: 8),
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: isBold == false ? interRegular : ralewayBold,
              fontSize: subTitleSize,
              color: subTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
