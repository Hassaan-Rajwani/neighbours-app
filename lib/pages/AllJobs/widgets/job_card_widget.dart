import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button_slim.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/rating_component.dart';

class JobCardWidget extends StatefulWidget {
  const JobCardWidget({
    required this.isSelected,
    required this.firstName,
    required this.lastName,
    required this.image1,
    required this.image2,
    required this.label,
    required this.sublabel,
    required this.onViewTap,
    this.packageLength,
    this.jobStatus,
    this.stars,
    super.key,
  });
  final bool isSelected;
  final String label;
  final String firstName;
  final String lastName;
  final String image1;
  final String image2;
  final String sublabel;
  final VoidCallback onViewTap;
  final double? stars;
  final List<dynamic>? packageLength;
  final String? jobStatus;

  @override
  State<JobCardWidget> createState() => _JobCardWidgetState();
}

class _JobCardWidgetState extends State<JobCardWidget> {
  bool fillselected = false;
  @override
  Widget build(BuildContext context) {
    final bytes = widget.image1 != 'null' && widget.image1 != ''
        ? base64Decode(widget.image1)
        : null;
    return Container(
      margin: EdgeInsets.only(bottom: SizeHelper.moderateScale(10)),
      padding: EdgeInsets.all(SizeHelper.moderateScale(15)),
      decoration: BoxDecoration(
        border: Border.all(color: doveGray, width: 0.2),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        bytes != null ? Colors.transparent : codGray,
                    backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                    radius: SizeHelper.moderateScale(15),
                    child: bytes == null
                        ? Text(
                            getInitials(
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                            ),
                            style: TextStyle(
                              fontFamily: ralewayBold,
                              fontSize: SizeHelper.moderateScale(12),
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const Gap(
                    gap: 15,
                    axis: 'x',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontFamily: ralewayBold,
                          color: codGray,
                          fontSize: SizeHelper.moderateScale(14),
                        ),
                      ),
                      RatingStars(
                        widget.stars == null ? 0 : widget.stars!,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Gap(gap: 20),
          Row(
            children: [
              SvgPicture.asset(
                widget.image2,
              ),
              const Gap(
                gap: 8,
                axis: 'x',
              ),
              Text(
                widget.sublabel,
                style: TextStyle(
                  fontFamily: ralewayMedium,
                  color: codGray,
                  fontSize: SizeHelper.moderateScale(16),
                ),
              ),
            ],
          ),
          const Gap(gap: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                allJobHandShakeIcon,
                color: cornflowerBlue,
              ),
              SvgPicture.asset(
                allJobPackageIcon,
                color: widget.jobStatus == 'COMPLETED' ||
                        widget.packageLength!.isNotEmpty
                    ? cornflowerBlue
                    : gallery,
              ),
              SvgPicture.asset(
                allJobTruckIcon,
                color:
                    widget.jobStatus == 'COMPLETED' ? cornflowerBlue : gallery,
              ),
            ],
          ),
          SizedBox(height: SizeHelper.moderateScale(6)),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: baliHai,
                    height: SizeHelper.moderateScale(4),
                    width: SizeHelper.getDeviceWidth(38),
                  ),
                  Container(
                    color: widget.packageLength!.isNotEmpty ? baliHai : gallery,
                    height: SizeHelper.moderateScale(4),
                    width: SizeHelper.getDeviceWidth(38),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: SizeHelper.moderateScale(16),
                    width: SizeHelper.moderateScale(16),
                    decoration: const BoxDecoration(
                      color: cornflowerBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: SizeHelper.moderateScale(10),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: SizeHelper.moderateScale(16),
                    width: SizeHelper.moderateScale(16),
                    decoration: BoxDecoration(
                      color: widget.jobStatus == 'COMPLETED' ||
                              widget.packageLength!.isNotEmpty
                          ? cornflowerBlue
                          : gallery,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: SizeHelper.moderateScale(10),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: SizeHelper.moderateScale(16),
                    width: SizeHelper.moderateScale(16),
                    decoration: BoxDecoration(
                      color: widget.jobStatus == 'COMPLETED'
                          ? cornflowerBlue
                          : gallery,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      allJobTruckLoader,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(gap: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booked',
                style: TextStyle(
                  color: doveGray,
                  fontFamily: interMedium,
                  fontSize: SizeHelper.moderateScale(8),
                ),
              ),
              Text(
                'Received',
                style: TextStyle(
                  color: doveGray,
                  fontFamily: interMedium,
                  fontSize: SizeHelper.moderateScale(8),
                ),
              ),
              Text(
                'Delivered',
                style: TextStyle(
                  color: doveGray,
                  fontFamily: interMedium,
                  fontSize: SizeHelper.moderateScale(8),
                ),
              ),
            ],
          ),
          const Gap(gap: 15),
          SizedBox(
            width: double.maxFinite,
            child: AppButtonSlim(
              onTap: () {
                widget.onViewTap();
              },
              text: 'View',
              textColor: Colors.white,
              btnColor: codGray,
            ),
          ),
        ],
      ),
    );
  }
}
