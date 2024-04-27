import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button_slim.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HelperPackageTrackingStep extends StatelessWidget {
  const HelperPackageTrackingStep({
    required this.acceptedDate,
    required this.deliveredDate,
    required this.stepNo,
    required this.pickupType,
    required this.confirmIcon,
    required this.packageStatus,
    required this.jobType,
    required this.onTap,
    required this.helperNmae,
    super.key,
  });
  final String acceptedDate;
  final String deliveredDate;
  final String stepNo;
  final VoidCallback onTap;
  final List<String> pickupType;
  final String confirmIcon;
  final String packageStatus;
  final String jobType;
  final String helperNmae;

  @override
  Widget build(BuildContext context) {
    final myDateTime = DateTime.now();

    return TimelineTile(
      endChild: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(10),
          vertical: SizeHelper.moderateScale(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (() {
                switch (stepNo) {
                  case '1':
                    return '''
You accepted the package on $acceptedDate''';
                  case '2':
                    return packageStatus == 'PENDING'
                        ? pickupType[0] == 'PICKUP'
                            ? 'Waiting for neighbor to receive'
                            : 'Waiting to deliver'
                        : pickupType[0] == 'PICKUP'
                            ? '''Package was picked up by $helperNmae on ${deliveredDate == '' ? myDateTime.toString() : deliveredDate} '''
                            : '''You Delivered the package on ${deliveredDate == '' ? myDateTime.toString() : deliveredDate}''';
                  default:
                    return '''
Something went wrong''';
                }
              })(),
              style: TextStyle(
                fontFamily: interMedium,
                fontSize: SizeHelper.moderateScale(12),
                color: (() {
                  switch (stepNo) {
                    case '2':
                      return packageStatus == 'PENDING' ? baliHai : codGray;
                    default:
                      return codGray;
                  }
                })(),
              ),
            ),
            const Gap(gap: 10),
            if (stepNo == '1')
              Column(
                children: [
                  const Gap(gap: 10),
                  SizedBox(
                    height: SizeHelper.moderateScale(30),
                    child: AppButtonSlim(
                      text: 'View Image',
                      textColor: Colors.white,
                      btnColor: cornflowerBlue,
                      onTap: onTap,
                    ),
                  ),
                ],
              )
            else
              Container(
                height: SizeHelper.moderateScale(30),
              ),
          ],
        ),
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: (() {
          switch (stepNo) {
            case '1':
              return 0.5;
            default:
              return 0.25;
          }
        })(),
        width: SizeHelper.moderateScale(12),
        height: SizeHelper.moderateScale(12),
        indicator: SvgPicture.asset(
          (() {
            switch (stepNo) {
              case '2':
                return packageStatus == 'PENDING'
                    ? confirmIcon
                    : packageCompletedIcon;

              default:
                return packageCompletedIcon;
            }
          })(),
          height: SizeHelper.moderateScale(12),
          width: SizeHelper.moderateScale(12),
        ),
      ),
      beforeLineStyle: LineStyle(
        color: alto,
        thickness: SizeHelper.moderateScale(2),
      ),
      afterLineStyle: LineStyle(
        color: alto,
        thickness: SizeHelper.moderateScale(2),
      ),
    );
  }
}
