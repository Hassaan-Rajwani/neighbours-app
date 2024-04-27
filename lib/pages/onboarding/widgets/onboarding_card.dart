import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    required this.item,
    super.key,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          item['image'] as String,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
        const Gap(gap: 45),
        SizedBox(
          width: SizeHelper.getDeviceWidth(65),
          child: Text(
            item['heading'] as String,
            style: TextStyle(
              fontSize: SizeHelper.moderateScale(24),
              fontFamily: ralewayExtrabold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(gap: 10),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(5),
          ),
          child: Text(
            item['text'] as String,
            style: TextStyle(
              fontSize: SizeHelper.moderateScale(14),
              fontFamily: interRegular,
              color: doveGray,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
