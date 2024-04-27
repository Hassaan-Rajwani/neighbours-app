// ignore_for_file: must_be_immutable, use_build_context_synchronously, omit_local_variable_types, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class SearchBarAndButton extends StatelessWidget {
  const SearchBarAndButton({
    required this.hintlabel,
    this.onChangeText,
    super.key,
  });
  final String hintlabel;
  final void Function(String)? onChangeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeHelper.moderateScale(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: SizeHelper.getDeviceWidth(89),
            child: TextField(
              onChanged: onChangeText,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(SizeHelper.moderateScale(8)),
                  borderSide: const BorderSide(color: Colors.grey, width: 0),
                ),
                contentPadding: EdgeInsets.zero,
                hintText: hintlabel,
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
      ),
    );
  }
}
