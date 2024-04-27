import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({
    required this.text1,
    required this.text2,
    required this.onPress,
    super.key,
    this.text1Color = Colors.black,
  });

  final String text1;
  final Color text1Color;
  final String text2;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: RichText(
        text: TextSpan(
          text: text1,
          style: TextStyle(
            color: text1Color,
            fontSize: SizeHelper.moderateScale(14),
            fontFamily: interRegular,
          ),
          children: [
            TextSpan(
              text: text2,
              style: TextStyle(
                color: const Color(0xFF63B1FB),
                fontSize: SizeHelper.moderateScale(16),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
