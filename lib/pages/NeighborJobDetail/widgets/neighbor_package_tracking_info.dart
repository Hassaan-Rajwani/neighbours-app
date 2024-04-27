import 'package:flutter/material.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_package_tracking_step.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class NeighborPackageTrackingInfo extends StatefulWidget {
  const NeighborPackageTrackingInfo({
    required this.packageNo,
    required this.helperName,
    required this.pickupType,
    required this.onViewTap,
    required this.onConfirmTap,
    required this.packageData,
    required this.isRecurring,
    required this.packageStatus,
    required this.jobType,
    required this.onConfirmIcon,
    required this.acceptedDate,
    required this.updatedDate,
    required this.tipStatus,
    super.key,
  });
  final String packageNo;
  final String helperName;
  final List<String> pickupType;
  final bool isRecurring;
  final VoidCallback onViewTap;
  final VoidCallback onConfirmTap;
  final List<NeighborsPackageModel> packageData;
  final String packageStatus;
  final String jobType;
  final String onConfirmIcon;
  final String acceptedDate;
  final String updatedDate;
  final bool tipStatus;

  @override
  State<NeighborPackageTrackingInfo> createState() =>
      _NeighborPackageTrackingInfoState();
}

class _NeighborPackageTrackingInfoState
    extends State<NeighborPackageTrackingInfo> {
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
                'Package ${widget.packageNo}',
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
                NeighborPackageTrackingStep(
                  acceptedDate: widget.acceptedDate,
                  helperName: widget.helperName,
                  pickupType: widget.pickupType,
                  stepNo: '1',
                  packageStatus: widget.packageStatus,
                  confirmIcon: widget.onConfirmIcon,
                  updatedDate: '',
                  onTap: widget.onViewTap,
                  jobType: widget.jobType,
                  tipStatus: widget.tipStatus,
                ),
                NeighborPackageTrackingStep(
                  tipStatus: widget.tipStatus,
                  acceptedDate: widget.acceptedDate,
                  updatedDate: widget.updatedDate,
                  helperName: widget.helperName,
                  pickupType: widget.pickupType,
                  stepNo: widget.isRecurring ? '3' : '2',
                  packageStatus: widget.packageStatus,
                  confirmIcon: widget.onConfirmIcon,
                  onTap: widget.onConfirmTap,
                  jobType: widget.jobType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
