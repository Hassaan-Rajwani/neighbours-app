import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/pages/HelperJobDetail/widgets/helper_package_tracking_info.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HelperPackageOuterTimelineTile extends StatefulWidget {
  const HelperPackageOuterTimelineTile({
    required this.isRecurring,
    required this.isDelivered,
    required this.packageList,
    required this.pickupType,
    required this.jobType,
    required this.neighborName,
    super.key,
  });
  final bool isRecurring;
  final bool isDelivered;
  final String jobType;
  final String neighborName;
  final List<String> pickupType;
  final List<NeighborsPackageModel> packageList;

  @override
  State<HelperPackageOuterTimelineTile> createState() =>
      _HelperPackageOuterTimelineTileState();
}

class _HelperPackageOuterTimelineTileState
    extends State<HelperPackageOuterTimelineTile> {
  String confirmIcon = inprogressPackageIconTwo;

  bool isOpen = true;

  void viewImage({required String baseImage}) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        final image = base64Decode(baseImage);
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(0),
            vertical: SizeHelper.getDeviceHeight(20),
          ),
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeHelper.moderateScale(16)),
            ),
            width: SizeHelper.moderateScale(350),
            padding: EdgeInsets.all(
              SizeHelper.moderateScale(20),
            ),
            child: SingleChildScrollView(
              child: Image.memory(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isOpen == true
          ? SizeHelper.moderateScale(240) * widget.packageList.length
          : SizeHelper.moderateScale(66) * widget.packageList.length,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.packageList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: SizeHelper.moderateScale(240),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TimelineTile(
                    endChild: Column(
                      children: [
                        HelperPackageTrackingInfo(
                          neighborName: widget.neighborName,
                          isRecurring: widget.isRecurring,
                          acceptedDate: extractDateAndTime2(
                            widget.packageList[index].createdAt,
                          ),
                          jobType: widget.jobType,
                          onConfirmIcon: confirmIcon,
                          onViewTap: () {
                            viewImage(
                              baseImage: widget.packageList[index].imageUrl,
                            );
                          },
                          packageList: widget.packageList,
                          packageStatus:
                              widget.packageList[index].status.toString(),
                          pickupType: widget.pickupType,
                          updatedDate: extractDateAndTime2(
                            widget.packageList[index].updatedAt,
                          ),
                          packageNo: (index + 1).toString(),
                        ),
                      ],
                    ),
                    afterLineStyle: LineStyle(
                      color: widget.packageList[index].status == 'PENDING'
                          ? gallery
                          : emerald,
                      thickness: SizeHelper.moderateScale(4),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: SizeHelper.moderateScale(16),
                      indicatorXY: 0,
                      indicator: SvgPicture.asset(
                        widget.packageList[index].status == 'PENDING'
                            ? inprogressPackageIcon
                            : packageCompletedIcon,
                      ),
                    ),
                    isFirst: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
