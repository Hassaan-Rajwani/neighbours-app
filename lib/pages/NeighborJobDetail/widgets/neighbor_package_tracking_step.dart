import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button_slim.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:timeline_tile/timeline_tile.dart';

class NeighborPackageTrackingStep extends StatelessWidget {
  const NeighborPackageTrackingStep({
    required this.helperName,
    required this.acceptedDate,
    required this.updatedDate,
    required this.stepNo,
    required this.pickupType,
    required this.confirmIcon,
    required this.packageStatus,
    required this.jobType,
    required this.onTap,
    required this.tipStatus,
    super.key,
  });
  final String helperName;
  final String acceptedDate;
  final String updatedDate;
  final String stepNo;
  final List<String> pickupType;
  final String confirmIcon;
  final String packageStatus;
  final String jobType;
  final VoidCallback onTap;
  final bool tipStatus;

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
                final deliveryStatus =
                    pickupType[0] == 'DELIVERY' ? 'Delivered' : 'Pickup';
                switch (stepNo) {
                  case '1':
                    return '''
Helper accepted the package on $acceptedDate''';
                  case '2':
                    return packageStatus == 'PENDING'
                        ? pickupType[0] == 'PICKUP'
                            ? 'Time to pick up! The helper is waiting for you.'
                            : 'Waiting to deliver'
                        : '''$helperName $deliveryStatus the package on ${updatedDate == '' ? myDateTime.toString() : updatedDate}''';
                  default:
                    return '''
Helper Delivered the Package on $acceptedDate''';
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
            SizedBox(
              height: SizeHelper.moderateScale(33),
              child: AppButtonSlim(
                text: (() {
                  switch (stepNo) {
                    case '1':
                      return 'View Image';
                    // case '2':
                    //   return packageStatus != 'PENDING'
                    //       ? jobType == 'RECURRING'
                    //           ? ''
                    //           : ''
                    //       : pickupType == 'PICKUP'
                    //           ? 'Confirm Parcel Picked Up'
                    //           : 'Confirm Parcel Recieved';
                    case '2':
                      return packageStatus != 'PENDING'
                          ? jobType == 'RECURRING'
                              ? tipStatus
                                  ? ''
                                  : 'Give Tip'
                              : ''
                          : pickupType[0] == 'PICKUP'
                              ? 'Confirm Parcel Picked Up'
                              : 'Confirm Parcel Recieved';
                    default:
                      return 'Give Tip';
                  }
                })(),
                textColor: Colors.white,
                btnColor: (() {
                  switch (stepNo) {
                    case '1':
                      return cornflowerBlue;
                    // case '2':
                    //   return packageStatus != 'PENDING'
                    //       ? jobType == 'RECURRING'
                    //           ? Colors.transparent
                    //           : Colors.transparent
                    //       : olivine;
                    case '2':
                      return packageStatus != 'PENDING'
                          ? jobType == 'RECURRING'
                              ? tipStatus
                                  ? Colors.transparent
                                  : casablanca
                              : Colors.transparent
                          : olivine;
                    default:
                      return casablanca;
                  }
                })(),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: (() {
          switch (stepNo) {
            case '2':
              return packageStatus != 'PENDING' ? 0.2 : 0.4;
            default:
              return 0.5;
          }
        })(),
        width: SizeHelper.moderateScale(12),
        height: SizeHelper.moderateScale(12),
        indicator: SvgPicture.asset(
          (() {
            switch (stepNo) {
              case '1':
                return packageCompletedIcon;
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
