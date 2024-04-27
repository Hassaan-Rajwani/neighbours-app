import 'package:flutter/material.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/pages/HelperJobDetail/widgets/helper_package_tracking_step.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class HelperPackageTrackingInfo extends StatelessWidget {
  const HelperPackageTrackingInfo({
    required this.packageNo,
    required this.pickupType,
    required this.onViewTap,
    required this.packageList,
    required this.isRecurring,
    required this.packageStatus,
    required this.jobType,
    required this.onConfirmIcon,
    required this.acceptedDate,
    required this.updatedDate,
    required this.neighborName,
    super.key,
  });
  final String packageNo;
  final List<String> pickupType;
  final bool isRecurring;
  final VoidCallback onViewTap;
  final List<NeighborsPackageModel> packageList;
  final String packageStatus;
  final String jobType;
  final String onConfirmIcon;
  final String acceptedDate;
  final String updatedDate;
  final String neighborName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Package $packageNo',
                style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(14),
                  color: codGray,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeHelper.moderateScale(15),
            ),
            child: Column(
              children: [
                HelperPackageTrackingStep(
                  helperNmae: neighborName,
                  onTap: onViewTap,
                  acceptedDate: acceptedDate,
                  deliveredDate: updatedDate,
                  stepNo: '1',
                  confirmIcon: onConfirmIcon,
                  jobType: jobType,
                  packageStatus: packageStatus,
                  pickupType: pickupType,
                ),
                HelperPackageTrackingStep(
                  helperNmae: neighborName,
                  onTap: () {},
                  acceptedDate: acceptedDate,
                  deliveredDate: updatedDate,
                  stepNo: '2',
                  confirmIcon: onConfirmIcon,
                  jobType: jobType,
                  packageStatus: packageStatus,
                  pickupType: pickupType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
