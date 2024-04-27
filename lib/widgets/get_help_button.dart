import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class GetHelpButton extends StatelessWidget {
  const GetHelpButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeHelper.moderateScale(10),
          horizontal: SizeHelper.moderateScale(30),
        ),
        child: Text(
          'Get Help',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: cornflowerBlue,
            fontFamily: interMedium,
            fontSize: SizeHelper.moderateScale(14),
          ),
        ),
      ),
    );
  }
}
