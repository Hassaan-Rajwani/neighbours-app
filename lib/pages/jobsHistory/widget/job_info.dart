import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({
    required this.names,
    required this.details,
    super.key,
    this.customize = false,
  });
  final String names;
  final String details;
  final bool customize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(15),
        vertical: SizeHelper.moderateScale(7),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            names,
            style: TextStyle(
              fontFamily: interSemibold,
              fontSize: SizeHelper.moderateScale(14),
              color: baliHai,
            ),
          ),
          if (customize)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: r'$ ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: SizeHelper.moderateScale(14),
                      fontWeight: FontWeight.w500,
                      color: cornflowerBlue,
                    ), // Set your desired color here
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: mineShaft,
                      fontFamily: 'Inter',
                      fontSize: SizeHelper.moderateScale(14),
                      fontWeight: FontWeight.w500,
                    ),
                    text: details, // Rest of the text
                  ),
                ],
              ),
            )
          else
            Text(
              details,
              style: TextStyle(
                fontSize: SizeHelper.moderateScale(14),
                fontFamily: interMedium,
              ),
            ),
        ],
      ),
    );
  }
}
