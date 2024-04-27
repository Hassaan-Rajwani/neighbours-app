import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class PendingJob extends StatelessWidget {
  const PendingJob({
    required this.jobLabel,
    required this.jobTypeLabel,
    required this.pickupLabel,
    required this.sizeLabel,
    required this.priceLabel,
    required this.backColor,
    required this.bidprice,
    required this.bidColor,
    super.key,
  });
  final String jobLabel;
  final String jobTypeLabel;
  final String pickupLabel;
  final String sizeLabel;
  final String priceLabel;
  final Color backColor;
  final String bidprice;
  final Color bidColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeHelper.moderateScale(114),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
        border: Border.all(color: codGray, width: 0.1),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          SizeHelper.moderateScale(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      packageJobIcon,
                    ),
                    const Gap(
                      gap: 5,
                      axis: 'x',
                    ),
                    Text(
                      jobLabel,
                      style: TextStyle(
                        fontFamily: ralewaySemibold,
                        fontSize: SizeHelper.moderateScale(14),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: backColor,
                    borderRadius:
                        BorderRadius.circular(SizeHelper.moderateScale(4)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeHelper.moderateScale(15),
                    vertical: SizeHelper.moderateScale(10),
                  ),
                  child: Text(
                    bidprice,
                    style: TextStyle(
                      color: bidColor,
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(8),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(gap: 5),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(SizeHelper.moderateScale(4)),
                  decoration: BoxDecoration(
                    color: polar,
                    borderRadius: BorderRadius.circular(
                      SizeHelper.moderateScale(8),
                    ),
                  ),
                  child: Text(
                    jobTypeLabel,
                    style: TextStyle(
                      color: baliHai,
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(10),
                    ),
                  ),
                ),
                const Gap(
                  gap: 05,
                  axis: 'x',
                ),
                Container(
                  padding: EdgeInsets.all(SizeHelper.moderateScale(4)),
                  decoration: BoxDecoration(
                    color: polar,
                    borderRadius: BorderRadius.circular(
                      SizeHelper.moderateScale(8),
                    ),
                  ),
                  child: Text(
                    pickupLabel,
                    style: TextStyle(
                      color: baliHai,
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(10),
                    ),
                  ),
                ),
                const Gap(
                  gap: 5,
                  axis: 'x',
                ),
                Container(
                  padding: EdgeInsets.all(SizeHelper.moderateScale(4)),
                  decoration: BoxDecoration(
                    color: polar,
                    borderRadius: BorderRadius.circular(
                      SizeHelper.moderateScale(8),
                    ),
                  ),
                  child: Text(
                    sizeLabel,
                    style: TextStyle(
                      color: baliHai,
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(10),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(gap: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$$priceLabel',
                style: TextStyle(
                  fontFamily: interSemibold,
                  fontSize: SizeHelper.moderateScale(14),
                  color: olivine,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
