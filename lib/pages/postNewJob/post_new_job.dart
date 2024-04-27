import 'package:flutter/material.dart';
import 'package:neighbour_app/pages/postNewJob/widgets/job_form.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_info.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/gap.dart';

class PostNewJobPage extends StatefulWidget {
  const PostNewJobPage({
    this.data,
    super.key,
  });

  static const routeName = '/post-new-job';

  final Map<String, dynamic>? data;

  @override
  State<PostNewJobPage> createState() => _PostNewJobPageState();
}

class _PostNewJobPageState extends State<PostNewJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gallery,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            backButtonAppbar(context, icon: const Icon(Icons.arrow_back)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeHelper.moderateScale(
                          20,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(SizeHelper.moderateScale(15)),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: cornflowerBlue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(
                            SizeHelper.moderateScale(8),
                          ),
                        ),
                        child: AppInfoWidget(
                          iconColor: cornflowerBlue,
                          title: 'Post New Job',
                          titleColor: cornflowerBlue,
                          subTitleColor: doveGray,
                          titleSize: SizeHelper.moderateScale(14),
                          subTitleSize: SizeHelper.moderateScale(10),
                          text:
                              '''Enter a title for the job your posting and select the details below to get the best matches with Helpers in your neighborhood''',
                        ),
                      ),
                    ),
                    const Gap(gap: 20),
                    JobForm(data: widget.data),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
