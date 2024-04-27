import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class HomeHeadingText extends StatelessWidget {
  const HomeHeadingText({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: SizeHelper.moderateScale(16),
          fontFamily: interSemibold,
          color: codGray,
        ),
      ),
    );
  }
}
