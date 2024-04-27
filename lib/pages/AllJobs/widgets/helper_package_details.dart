import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelperPackageDetails extends StatelessWidget {
  const HelperPackageDetails({
    required this.image,
    required this.title,
    required this.typeText,
    this.borderDirectional,
    this.imageColor,
    super.key,
    this.padding = false,
    this.amount = false,
  });
  final String image;
  final String title;
  final String typeText;
  final BorderDirectional? borderDirectional;
  final Color? imageColor;
  final bool padding;
  final bool amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: borderDirectional),
        child: Padding(
          padding: padding
              ? EdgeInsets.only(
                  left: SizeHelper.moderateScale(10),
                  top: SizeHelper.moderateScale(2),
                  bottom: SizeHelper.moderateScale(12),
                )
              : EdgeInsets.only(
                  top: SizeHelper.moderateScale(2),
                  bottom: SizeHelper.moderateScale(12),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    image,
                    color: imageColor,
                    height: SizeHelper.moderateScale(18),
                    width: SizeHelper.moderateScale(18),
                  ),
                  const Gap(
                    gap: 5,
                    axis: 'x',
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(12),
                      color: baliHai,
                    ),
                  ),
                ],
              ),
              if (amount == false) const Gap(gap: 10) else const Gap(gap: 7),
              Text(
                typeText,
                style: amount == true
                    ? TextStyle(
                        fontFamily: interBold,
                        fontSize: SizeHelper.moderateScale(14),
                        color: chateauGreen,
                      )
                    : TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(12),
                        color: codGray,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
