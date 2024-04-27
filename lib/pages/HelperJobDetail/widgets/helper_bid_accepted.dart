import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/data/models/get_neighbors_package.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/pages/HelperJobDetail/widgets/helper_package_outer_timeline_tile.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelperBidAcceptedWidget extends StatefulWidget {
  const HelperBidAcceptedWidget({
    required this.packageList,
    required this.data,
    super.key,
  });

  final List<NeighborsPackageModel> packageList;
  final HelperJobModel data;

  @override
  State<HelperBidAcceptedWidget> createState() =>
      _HelperBidAcceptedWidgetState();
}

class _HelperBidAcceptedWidgetState extends State<HelperBidAcceptedWidget> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      '''Your Bid was Accepted by ${widget.data.neighbourId.firstName} ${widget.data.neighbourId.lastName}''',
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
                    extractDateAndTime(
                      widget.data.updatedAt,
                    ),
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
          if (widget.packageList.isEmpty)
            Column(
              children: [
                const Gap(gap: 60),
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
                const Gap(gap: 30)
              ],
            )
          else
            HelperPackageOuterTimelineTile(
              neighborName:
                  '''${widget.data.neighbourId.firstName} ${widget.data.neighbourId.lastName}''',
              isRecurring: widget.data.type.pascalCase == 'Recurring',
              isDelivered: true,
              jobType: widget.data.type,
              packageList: widget.packageList,
              pickupType: widget.data.pickupType,
            ),
        ],
      ),
    );
  }
}
