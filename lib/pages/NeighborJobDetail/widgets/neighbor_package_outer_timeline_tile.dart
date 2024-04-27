// ignore_for_file: inference_failure_on_function_invocation, unnecessary_statements, lines_longer_than_80_chars
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_package_tracking_info.dart';
import 'package:neighbour_app/pages/neighborGiveTip/neighbor_give_tip.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/neighbor_give_rating.dart';
import 'package:neighbour_app/presentation/bloc/neighborsPackages/neighbors_packages_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:timeline_tile/timeline_tile.dart';

class NeighborPackageOuterTimelineTile extends StatefulWidget {
  const NeighborPackageOuterTimelineTile({
    required this.packageData,
    required this.jobData,
    this.numberOfPackage = 2,
    super.key,
  });
  final int numberOfPackage;
  final List<NeighborsPackageModel> packageData;
  final JobByIdModel jobData;

  @override
  State<NeighborPackageOuterTimelineTile> createState() =>
      _NeighborPackageOuterTimelineTileState();
}

class _NeighborPackageOuterTimelineTileState
    extends State<NeighborPackageOuterTimelineTile> {
  bool isOpen = true;
  String confirmIcon = inprogressPackageIconTwo;
  bool tipStatus = true;

  void viewImage({required String baseImage}) {
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

  void confirmDialog({
    required BuildContext context,
    required int index,
    required String type,
  }) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              GlassContainer(
                blur: 5,
                child: Container(
                  height: SizeHelper.getDeviceHeight(100),
                  width: SizeHelper.getDeviceWidth(100),
                  color: Colors.transparent,
                ),
              ),
              CustomDialogBox(
                onConfirmPressed: () {
                  if (widget.jobData.type == 'ONE_TIME') {
                    sl<NeighborsPackagesBloc>().add(
                      UpdateNeighborsPackage(
                        jobId: widget.packageData[index].jobId,
                        packageId: widget.packageData[index].id,
                      ),
                    );
                    final query = Uri(
                      queryParameters: {
                        'helperName':
                            '''${widget.jobData.helperId!.firstName} ${widget.jobData.helperId!.lastName}''',
                        'image': widget.jobData.helperId!.imageUrl.toString(),
                        'jobId': widget.jobData.id,
                        'firstName': widget.jobData.helperId!.firstName,
                        'lastName': widget.jobData.helperId!.lastName,
                      },
                    ).query;
                    context
                      ..pop()
                      ..pop()
                      ..push('${NeighborGiveRatingPage.routeName}?$query');
                  } else {
                    sl<NeighborsPackagesBloc>().add(
                      UpdateNeighborsPackage(
                        jobId: widget.packageData[index].jobId,
                        packageId: widget.packageData[index].id,
                      ),
                    );
                    context.pop();
                  }
                },
                onCancelPressed: context.pop,
                confirmText: 'Confirm',
                cancelText: 'Cancel',
                confirmTextColor: Colors.white,
                cancelTextColor: doveGray,
                confirmBtnBackgroundColor: olivine,
                cancelBtnBackgroundColor: silver,
                heading: 'Confirm $type',
                verticalHeight: Platform.isAndroid ? 36 : 33,
                description:
                    '''If you just picked up a parcel, click confirm''',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onConfirm({required int index}) async {
    final query = Uri(
      queryParameters: {
        'jobId': widget.jobData.id,
        'packageId': widget.packageData[index].id,
      },
    ).query;
    widget.packageData[index].status == 'PENDING'
        ? confirmDialog(
            context: context,
            index: index,
            type: widget.jobData.pickupType[index] == 'Pickup'
                ? 'Parcel Picked Up'
                : 'Parcel Recieved',
          )
        : widget.packageData[index].status == 'CONFIRMED'
            ? widget.jobData.type == 'ONE_TIME'
                ? () {}
                : widget.packageData[index].tipStatus
                    ? () {}
                    : context.push('${NeighborGiveTipPage.routeName}?$query')
            : () {};
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isOpen == true
          ? SizeHelper.moderateScale(240) * widget.packageData.length
          : SizeHelper.moderateScale(66) * widget.packageData.length,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.packageData.length,
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
                        NeighborPackageTrackingInfo(
                          helperName:
                              '''${widget.jobData.helperId!.firstName} ${widget.jobData.helperId!.lastName}''',
                          packageNo: (index + 1).toString(),
                          packageData: widget.packageData,
                          isRecurring: checkJobTypeFormat(
                                widget.jobData.type,
                              ) ==
                              'RECURRING',
                          pickupType: widget.jobData.pickupType,
                          jobType: widget.jobData.type,
                          tipStatus: widget.packageData[index].tipStatus,
                          acceptedDate: extractDateAndTime2(
                            widget.packageData[index].createdAt,
                          ),
                          updatedDate: extractDateAndTime2(
                            widget.packageData[index].updatedAt,
                          ),
                          packageStatus:
                              widget.packageData[index].status.toString(),
                          onViewTap: () {
                            viewImage(
                              baseImage: widget.packageData[index].imageUrl,
                            );
                          },
                          onConfirmTap: () {
                            onConfirm(index: index);
                          },
                          onConfirmIcon: confirmIcon,
                        ),
                      ],
                    ),
                    afterLineStyle: LineStyle(
                      color: widget.packageData[index].status == 'PENDING'
                          ? gallery
                          : emerald,
                      thickness: SizeHelper.moderateScale(4),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: SizeHelper.moderateScale(16),
                      indicatorXY: 0,
                      indicator: SvgPicture.asset(
                        widget.packageData[index].status == 'PENDING'
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
