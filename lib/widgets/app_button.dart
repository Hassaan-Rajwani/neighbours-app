import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    this.onPress,
    this.backgroundColor = cornflowerBlue,
    this.buttonLoader = false,
    this.textColor = Colors.white,
    this.horizontalMargin = 20,
    this.minWidth = 390.0, // Set the minimum width
    super.key,
  });

  final VoidCallback? onPress;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? buttonLoader;
  final int? horizontalMargin;
  final double minWidth; // Minimum width property

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(horizontalMargin!),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the button width based on minWidth and available width
          final buttonWidth = constraints.maxWidth < minWidth
              ? minWidth // Use minWidth if available width is less
              : constraints.maxWidth; // Use available width if greater

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: backgroundColor,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SizeHelper.moderateScale(8),
                ),
              ),
              textStyle: TextStyle(
                fontSize: SizeHelper.moderateScale(16),
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
              padding: EdgeInsets.symmetric(
                vertical: SizeHelper.moderateScale(18),
              ),
              elevation: 0,
              minimumSize: Size(buttonWidth, 0), // Set the button width
            ),
            onPressed: buttonLoader! ? null : onPress,
            child: buttonLoader!
                ? SizedBox(
                    height: SizeHelper.moderateScale(20),
                    width: SizeHelper.moderateScale(20),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: SizeHelper.moderateScale(16),
                      fontFamily: 'PoppinsMedium',
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
          );
        },
      ),
    );
  }
}
