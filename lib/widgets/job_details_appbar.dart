import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class JobDetailsAppbar extends StatelessWidget {
  const JobDetailsAppbar({
    required this.onTap,
    this.heading = 'Job Details',
    super.key,
  });
  final VoidCallback onTap;
  final String? heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: SizeHelper.moderateScale(17),
        right: SizeHelper.moderateScale(20),
        left: SizeHelper.moderateScale(20),
        top: SizeHelper.moderateScale(17),
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      width: SizeHelper.getDeviceWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: SizeHelper.moderateScale(35),
            width: SizeHelper.moderateScale(35),
            decoration: const BoxDecoration(
              color: cornflowerBlue,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: context.pop,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            heading!,
            style: TextStyle(
              fontFamily: interSemibold,
              fontSize: SizeHelper.moderateScale(16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeHelper.moderateScale(08)),
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
              onTap: onTap,
              child: SvgPicture.asset(messengerIcon),
            ),
          ),
        ],
      ),
    );
  }
}
