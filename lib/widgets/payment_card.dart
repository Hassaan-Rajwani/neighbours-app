import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    required this.cardIcon,
    required this.cardTitle,
    required this.cardPin,
    required this.isDefault,
    this.pinTextColor,
    super.key,
  });
  final String cardIcon;
  final String cardTitle;
  final String cardPin;
  final Color? pinTextColor;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Visibility(
        visible: isDefault,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(SizeHelper.moderateScale(8)),
              bottomRight: Radius.circular(SizeHelper.moderateScale(8)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeHelper.moderateScale(16)),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    cardIcon,
                  ),
                ),
                SizedBox(width: SizeHelper.moderateScale(21)),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardTitle,
                          style: TextStyle(
                            fontSize: SizeHelper.moderateScale(10),
                            fontFamily: ralewaySemibold,
                            color: mineShaft,
                          ),
                        ),
                        SizedBox(height: SizeHelper.moderateScale(15)),
                        Text(
                          cardPin,
                          style: TextStyle(
                            fontSize: SizeHelper.moderateScale(14),
                            fontFamily: interBold,
                            color: pinTextColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
