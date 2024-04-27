// ignore_for_file: lines_longer_than_80_chars

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:neighbour_app/data/models/job_model_with_helper_info.dart';
import 'package:neighbour_app/pages/jobsHistory/widget/job_info.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class JobHistoryCard extends StatefulWidget {
  const JobHistoryCard({
    required this.jobData,
    required this.onTap,
    super.key,
  });

  final JobModelWithHelperInfo jobData;
  final VoidCallback onTap;

  @override
  State<JobHistoryCard> createState() => _JobHistoryCardState();
}

class _JobHistoryCardState extends State<JobHistoryCard> {
  bool showHelperName = false;

  @override
  Widget build(BuildContext context) {
    if (widget.jobData.helperId != null) {
      setState(() {
        showHelperName = true;
      });
    } else {
      setState(() {
        showHelperName = false;
      });
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            SizeHelper.moderateScale(8),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: mercury,
            spreadRadius: SizeHelper.moderateScale(1),
            blurRadius: SizeHelper.moderateScale(4),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: SizeHelper.moderateScale(20),
      ),
      margin: EdgeInsets.only(
        bottom: SizeHelper.moderateScale(20),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          children: [
            OrderInfoWidget(
              names: 'Order No',
              details: '#${widget.jobData.id.substring(0, 10)}',
            ),
            if (showHelperName)
              OrderInfoWidget(
                names: 'Name',
                details:
                    '${widget.jobData.helperId!.firstName.pascalCase} ${widget.jobData.helperId!.lastName.pascalCase}',
              ),
            OrderInfoWidget(
              names: 'Pay Amount',
              details: widget.jobData.status == 'CANCELLED'
                  ? '0'
                  : widget.jobData.budget.toString(),
              customize: true,
            ),
            OrderInfoWidget(
              names: 'Size',
              details: widget.jobData.size[0].pascalCase,
            ),
            const Gap(gap: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  jobStatusCheck(status: widget.jobData.status),
                  style: TextStyle(
                    fontSize: SizeHelper.moderateScale(
                      16,
                    ),
                    fontFamily: ralewayBold,
                    color: statusCheckForColor(status: widget.jobData.status),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
