import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/models/job_by_id_model.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/neighbor_package_outer_timeline_tile.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NeighborAcceptedBidWidget extends StatefulWidget {
  const NeighborAcceptedBidWidget({
    required this.packageData,
    required this.data,
    super.key,
  });

  final List<NeighborsPackageModel> packageData;
  final JobByIdModel data;
  @override
  State<NeighborAcceptedBidWidget> createState() =>
      _NeighborAcceptedBidWidgetState();
}

class _NeighborAcceptedBidWidgetState extends State<NeighborAcceptedBidWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: polar,
      padding: EdgeInsets.symmetric(
        vertical: SizeHelper.moderateScale(
          15,
        ),
        horizontal: SizeHelper.moderateScale(
          20,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  SizeHelper.moderateScale(10),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cornflowerBlue.withOpacity(0.05),
                ),
                child: SvgPicture.asset(
                  handShaketwo,
                  height: SizeHelper.moderateScale(24),
                  width: SizeHelper.moderateScale(24),
                ),
              ),
              const Gap(
                gap: 10,
                axis: 'x',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeHelper.getDeviceWidth(70),
                    child: Text(
                      'You accepted the bid from helper',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(14),
                        color: codGray,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  const Gap(gap: 5),
                  Text(
                    extractDateAndTime(widget.data.createdAt),
                    style: TextStyle(
                      fontFamily: interSemibold,
                      fontSize: SizeHelper.moderateScale(10),
                      color: baliHai,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(gap: 20),
          if (widget.packageData.isEmpty)
            Column(
              children: [
                SvgPicture.asset(noPackageImage),
                const Gap(gap: 40),
                Text(
                  'No Packages Yet',
                  style: TextStyle(
                    fontFamily: interSemibold,
                    fontSize: SizeHelper.moderateScale(16),
                    color: codGray,
                  ),
                ),
                const Gap(gap: 30),
              ],
            )
          else
            NeighborPackageOuterTimelineTile(
              packageData: widget.packageData,
              jobData: widget.data,
            ),
        ],
      ),
    );
  }
}
