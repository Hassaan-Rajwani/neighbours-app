import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: SizeHelper.getDeviceWidth(90),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SizeHelper.moderateScale(8)),
                borderSide: const BorderSide(color: Colors.grey, width: 0),
              ),
              contentPadding: EdgeInsets.zero,
              hintText: 'Search for Jobs',
              hintStyle: TextStyle(
                fontFamily: interMedium,
                fontSize: SizeHelper.moderateScale(14),
                color: doveGray,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SizeHelper.moderateScale(8)),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: SizeHelper.moderateScale(22),
                  right: SizeHelper.moderateScale(10),
                ),
                child: InkWell(
                  child: SvgPicture.asset(
                    searchIcon,
                    color: codGray,
                    height: SizeHelper.moderateScale(24),
                    width: SizeHelper.moderateScale(24),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
