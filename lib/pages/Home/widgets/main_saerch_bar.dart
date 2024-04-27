import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class MainSearchbar extends StatelessWidget {
  const MainSearchbar({
    required this.borderRadius,
    super.key,
    this.filledColor = wildSand,
    this.iconColor = silverColor,
    this.textColor = silverColor,
    this.hintText = 'Search for Jobs',
    this.controller,
    this.onChangeText,
    this.suffixIcon,
  });

  final Color? filledColor;
  final Color? iconColor;
  final Color? textColor;
  final String? hintText;
  final double borderRadius;
  final TextEditingController? controller;
  final void Function(String)? onChangeText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeHelper.moderateScale(50),
      child: TextField(
        onChanged: onChangeText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: filledColor,
          contentPadding: EdgeInsets.all(SizeHelper.moderateScale(30)),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: interMedium,
            fontSize: SizeHelper.moderateScale(14),
            color: textColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: SizeHelper.moderateScale(22),
              right: SizeHelper.moderateScale(10),
            ),
            child: SvgPicture.asset(
              searchIcon,
              color: silverColor,
              height: SizeHelper.moderateScale(24),
              width: SizeHelper.moderateScale(24),
            ),
          ),
        ),
      ),
    );
  }
}
