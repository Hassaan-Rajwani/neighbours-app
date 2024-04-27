import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class IconRow extends StatelessWidget {
  const IconRow({
    required this.activeJobItem,
    super.key,
    this.icon,
    this.color = Colors.white,
  });

  final String activeJobItem;
  final String? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon!,
          color: color,
        ),
        const Gap(
          gap: 8,
          axis: 'x',
        ),
        Text(
          activeJobItem,
          style: TextStyle(
            fontFamily: ralewayMedium,
            color: Colors.white,
            fontSize: SizeHelper.moderateScale(12),
          ),
        ),
      ],
    );
  }
}
