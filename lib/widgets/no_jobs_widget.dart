import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NoJobsWidget extends StatelessWidget {
  const NoJobsWidget({
    required this.text,
    this.gap = 160,
    super.key,
  });

  final String text;
  final int gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(gap: gap),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(111),
          ),
          child: SvgPicture.asset(
            spaceship,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: urbanistSemiBold,
            fontSize: SizeHelper.moderateScale(20),
            color: mineShaft,
          ),
        ),
      ],
    );
  }
}
