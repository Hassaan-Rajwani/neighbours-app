import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class AppButtonSlim extends StatelessWidget {
  const AppButtonSlim({
    required this.text,
    required this.textColor,
    required this.btnColor,
    required this.onTap,
    super.key,
  });
  final String text;
  final Color textColor;
  final Color btnColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.1)),
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              SizeHelper.moderateScale(8),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(btnColor),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: interSemibold,
          fontSize: SizeHelper.moderateScale(12),
        ),
      ),
    );
  }
}
