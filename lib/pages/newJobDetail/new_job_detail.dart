// ignore_for_file: lines_longer_than_80_chars
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/newJobDetail/widgets/new_job_detail_description.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/rating_box.dart';

class NewJobDetailPage extends StatefulWidget {
  const NewJobDetailPage({
    required this.jobInfo,
    super.key,
  });
  final Map<String, dynamic> jobInfo;

  static const routeName = '/new-job-detail';

  @override
  State<NewJobDetailPage> createState() => _NewJobDetailPageState();
}

class _NewJobDetailPageState extends State<NewJobDetailPage> {
  @override
  Widget build(BuildContext context) {
    final bytes = widget.jobInfo['image'] != '' &&
            widget.jobInfo['image'] != 'null' &&
            widget.jobInfo['image'] != null
        ? base64Decode(widget.jobInfo['image'].toString())
        : null;
    return Scaffold(
      backgroundColor: athensGray,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              text: 'Job Detail',
              backgroundColor: athensGray,
            ),
            ColoredBox(
              color: Colors.white,
              child: Column(
                children: [
                  const Gap(
                    gap: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  bytes != null ? MemoryImage(bytes) : null,
                              backgroundColor:
                                  bytes != null ? Colors.transparent : codGray,
                              child: bytes == null
                                  ? Text(
                                      getInitials(
                                        firstName: widget.jobInfo['firstName']
                                            .toString(),
                                        lastName: widget.jobInfo['lastName']
                                            .toString(),
                                      ),
                                      style: TextStyle(
                                        fontFamily: ralewayBold,
                                        fontSize: SizeHelper.moderateScale(16),
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
                              children: [
                                Text(
                                  '${widget.jobInfo['name']}',
                                  style: TextStyle(
                                    fontSize: SizeHelper.moderateScale(14),
                                    fontFamily: ralewayBold,
                                  ),
                                ),
                                const Gap(
                                  gap: 6,
                                ),
                                RatingBox(
                                  rating: widget.jobInfo['rating'].toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeHelper.moderateScale(08)),
                          padding: EdgeInsets.all(
                            SizeHelper.moderateScale(10),
                          ),
                          height: SizeHelper.moderateScale(44),
                          width: SizeHelper.moderateScale(44),
                          decoration: BoxDecoration(
                            color: cornflowerBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                SizeHelper.moderateScale(100),
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              final profleState =
                                  BlocProvider.of<ProfileBloc>(context).state;
                              final query = Uri(
                                queryParameters: {
                                  'name': widget.jobInfo['name'],
                                  'firstName': widget.jobInfo['firstName'],
                                  'lastName': widget.jobInfo['lastName'],
                                  'userId': profleState is ProfileInitial
                                      ? profleState.id
                                      : 0,
                                  'helperId': widget.jobInfo['neighborId'],
                                  'image': widget.jobInfo['image'],
                                },
                              ).query;
                              context.push(
                                '${ChatPage.routeName}?$query',
                              );
                            },
                            child: SvgPicture.asset(messengerIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(gap: 20),
                  SizedBox(
                    height: SizeHelper.getDeviceHeight(76),
                    child: SingleChildScrollView(
                      child: NewJobDetailDescription(
                        title: widget.jobInfo['title'].toString(),
                        description: widget.jobInfo['description'].toString(),
                        budget: widget.jobInfo['budget'].toString(),
                        distance:
                            '${widget.jobInfo['helperDistance']} ${widget.jobInfo['distanceUnit']}',
                        type: checkJobTypeFormat(
                            widget.jobInfo['type'].toString()),
                        pickupType: widget.jobInfo['pickup_type'].toString(),
                        size: widget.jobInfo['size'].toString().pascalCase,
                        lat: widget.jobInfo['lat'].toString(),
                        long: widget.jobInfo['long'].toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
