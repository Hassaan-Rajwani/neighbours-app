import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class SloganIcon extends StatelessWidget {
  const SloganIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          splashImage,
          height: SizeHelper.moderateScale(42),
          width: SizeHelper.moderateScale(47),
        ),
        const Gap(
          gap: 15,
          axis: 'x',
        ),
        Text(
          'Neighbors Helping Neighbors',
          style: TextStyle(
            fontFamily: interSemibold,
            fontSize: SizeHelper.moderateScale(14),
            color: codGray,
          ),
        ),
      ],
    );
  }
}
