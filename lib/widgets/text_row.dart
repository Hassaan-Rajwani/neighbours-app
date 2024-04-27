import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class TextRow extends StatelessWidget {
  const TextRow({
    this.label2,
    this.label1,
    this.onTap,
    this.color = cornflowerBlue,
    super.key,
  });

  final String? label1;
  final String? label2;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label1!,
          style: TextStyle(
            color: shark,
            fontFamily: ralewayBold,
            fontSize: SizeHelper.moderateScale(16),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            label2!,
            style: TextStyle(
              fontFamily: interMedium,
              fontSize: SizeHelper.moderateScale(14),
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
