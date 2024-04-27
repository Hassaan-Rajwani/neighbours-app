import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class TipOptionWidget extends StatelessWidget {
  const TipOptionWidget({
    required this.text, required this.isTapped, super.key,
    this.selected = 'No tip',
  });
  final String text;
  final bool isTapped;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isTapped == true ? cornflowerBlue : Colors.white,
        border: isTapped == false
            ? Border.all(
                color: baliHai,
              )
            : Border.all(color: cornflowerBlue),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
        vertical: SizeHelper.moderateScale(15),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: ralewaySemibold,
            fontSize: SizeHelper.moderateScale(12),
            color: isTapped == true ? Colors.white : baliHai,),
      ),
    );
  }
}
