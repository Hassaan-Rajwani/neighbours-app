import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class CreditCardForm extends StatelessWidget {
  const CreditCardForm({
    required this.cardIcon,
    required this.cardTitle,
    required this.cardPin,
    required this.onCardSelected,
    required this.index,
    required this.defaultLabel,
    required this.onDeleteTap,
    required this.isDefault,
    super.key,
    this.onDefaultChanged,
    this.pinTextColor,
    this.borderColor,
  });
  final String cardIcon;
  final String cardTitle;
  final String cardPin;
  final bool isDefault;
  final void Function(bool?)? onDefaultChanged;
  final Color? pinTextColor;
  final Color? borderColor;
  final ValueChanged<int> onCardSelected;
  final void Function()? onDeleteTap;
  final int index;
  final String defaultLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardSelected(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(16),
          vertical: SizeHelper.moderateScale(8),
        ),
        child: Container(
          height: SizeHelper.moderateScale(100),
          padding: EdgeInsets.only(left: SizeHelper.moderateScale(10)),
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius:
                BorderRadius.all(Radius.circular(SizeHelper.moderateScale(8))),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: dinGray,
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
                          SizedBox(height: SizeHelper.moderateScale(8)),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            defaultLabel,
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(10),
                              fontFamily: ralewayBold,
                            ),
                          ),
                          const Gap(
                            gap: 15,
                            axis: 'x',
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              SizeHelper.moderateScale(2),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: cornflowerBlue,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeHelper.moderateScale(
                                  100,
                                ),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  isDefault ? cornflowerBlue : Colors.white,
                              radius: 6,
                            ),
                          ),
                          const Gap(
                            gap: 10,
                            axis: 'x',
                          ),
                          if (!isDefault)
                            GestureDetector(
                              onTap: onDeleteTap,
                              child: SvgPicture.asset(
                                deleteIcon,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
