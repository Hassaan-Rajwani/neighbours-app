import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    this.backColor = codGray,
    this.backgroundColor,
    super.key,
  });
  final String title;
  final Color? backColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: SizeHelper.moderateScale(17),
        right: SizeHelper.moderateScale(20),
        left: SizeHelper.moderateScale(20),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.black.withOpacity(0.1)),
        ),
      ),
      width: SizeHelper.getDeviceWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: SizeHelper.moderateScale(45),
            width: SizeHelper.moderateScale(45),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizeHelper.moderateScale(100),
                ),
              ),
            ),
            child: InkWell(
              onTap: context.pop,
              child: Icon(
                Icons.arrow_back,
                color: backColor,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: interSemibold,
              fontSize: SizeHelper.moderateScale(16),
            ),
          ),
          Container(
            width: SizeHelper.moderateScale(45),
          ),
        ],
      ),
    );
  }
}
