import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    super.key,
    this.icon,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(42),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: SizeHelper.moderateScale(1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          width: SizeHelper.moderateScale(345),
          height: SizeHelper.moderateScale(54),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null) icon!,
              Text(
                label,
                style: TextStyle(
                  fontSize: SizeHelper.moderateScale(20),
                  color: textColor,
                  fontFamily: interMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
