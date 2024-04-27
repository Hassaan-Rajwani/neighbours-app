// ignore_for_file: prefer_interpolation_to_compose_strings, lines_longer_than_80_chars

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:neighbour_app/data/models/helper_active_job.dart';
import 'package:neighbour_app/pages/jobsHistory/widget/job_info.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelperJobHistoryCard extends StatelessWidget {
  const HelperJobHistoryCard({
    required this.jobData,
    required this.onTap,
    super.key,
  });

  final HelperActiveJobModel jobData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
        onTap: onTap,
        child: Column(
          children: [
            OrderInfoWidget(
              names: 'Order No',
              details: '#${jobData.id.substring(0, 10)}',
            ),
            OrderInfoWidget(
              names: 'Name',
              details:
                  '''${jobData.neighbourId.firstName.pascalCase} ${jobData.neighbourId.lastName.pascalCase}''',
            ),
            OrderInfoWidget(
              names: 'Pay Amount',
              details: jobData.status == 'CANCELLED'
                  ? '0'
                  : jobData.amount.toString(),
              customize: true,
            ),
            OrderInfoWidget(
              names: 'Size',
              details: jobData.size[0].pascalCase,
            ),
            const Gap(gap: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  jobStatusCheck(status: jobData.status),
                  style: TextStyle(
                    fontSize: SizeHelper.moderateScale(
                      16,
                    ),
                    fontFamily: ralewayBold,
                    color: statusCheckForColor(status: jobData.status),
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
