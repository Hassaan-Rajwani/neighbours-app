import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    required this.label,
    required this.hintText,
    required this.controller,
    super.key,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: SizeHelper.moderateScale(10),
            fontFamily: ralewaySemibold,
            color: mineShaft,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: athensGray,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: interSemibold,
              fontSize: SizeHelper.moderateScale(10),
              color: silverColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: athensGray),
              borderRadius: BorderRadius.circular(
                SizeHelper.moderateScale(8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: athensGray,
              ),
              borderRadius: BorderRadius.circular(
                SizeHelper.moderateScale(8),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }
}
