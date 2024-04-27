import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    required this.isText,
    required this.onTap,
    super.key,
  });

  final bool isText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: SizeHelper.moderateScale(60),
        width: SizeHelper.moderateScale(isText ? 120 : 60),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(
              SizeHelper.moderateScale(8),
            ),
          ),
        ),
        child: isText
            ? Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(
                    5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    const Gap(
                      gap: 5,
                      axis: 'x',
                    ),
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: SizeHelper.moderateScale(12),
                        color: Colors.white,
                        fontFamily: ralewayExtrabold,
                      ),
                    ),
                  ],
                ),
              )
            : const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
      ),
    );
  }
}
