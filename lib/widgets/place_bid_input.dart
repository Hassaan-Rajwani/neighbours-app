import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class PlaceBidInput extends StatelessWidget {
  const PlaceBidInput({
    required TextEditingController textEditingController,
    super.key,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: SizeHelper.moderateScale(30),
        maxWidth: SizeHelper.moderateScale(120),
      ),
      height: SizeHelper.moderateScale(45),
      child: TextField(
        style: TextStyle(
          fontFamily: interSemibold,
          fontSize: SizeHelper.moderateScale(24),
          color: codGray,
        ),
        keyboardType: TextInputType.number,
        maxLength: 5,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(
              _textEditingController.text.isNotEmpty ? 10 : 30,
            ),
          ),
          prefixStyle: TextStyle(
            fontSize: SizeHelper.moderateScale(26),
            fontWeight: FontWeight.bold,
          ),
          prefixText: r'$',
          filled: true,
          fillColor: Colors.white,
          counterText: '',
        ),
        controller: _textEditingController,
      ),
    );
  }
}
