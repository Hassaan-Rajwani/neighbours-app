// ignore_for_file: must_be_immutable, use_build_context_synchronously, omit_local_variable_types, lines_longer_than_80_chars
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/pages/AllJobs/widgets/filter_bottom_sheet.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelpersSearchBarAndButton extends StatelessWidget {
  const HelpersSearchBarAndButton({
    this.onChangeText,
    this.onTap,
    this.onReset,
    this.label,
    super.key,
  });
  final void Function(double, double)? onTap;
  final void Function()? onReset;
  final void Function(String)? onChangeText;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeHelper.moderateScale(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: SizeHelper.getDeviceWidth(
              62,
            ),
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
                hintText: label,
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
          Row(
            children: [
              const Gap(
                gap: 10,
                axis: 'x',
              ),
              InkWell(
                highlightColor: silverColor,
                onTap: () {
                  helpersFilterBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeHelper.moderateScale(10),
                    vertical: SizeHelper.moderateScale(
                      Platform.isAndroid ? 17 : 15,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: cornflowerBlue,
                    borderRadius:
                        BorderRadius.circular(SizeHelper.moderateScale(8)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(filterIcon),
                      const Gap(gap: 5, axis: 'x'),
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: interMedium,
                          fontSize: SizeHelper.moderateScale(12),
                        ),
                      ),
                      const Gap(gap: 5, axis: 'x'),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: SizeHelper.moderateScale(12),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> helpersFilterBottomSheet(BuildContext context) async {
    final stars = await getDataFromStorage(StorageKeys.helperNeighbrRating);
    final miles = await getDataFromStorage(StorageKeys.helperNeighbrDistance);
    double helperRating = 0;
    double helperDistance = 0;
    helperRating = stars != null ? double.parse(stars) : 0;
    helperDistance = miles != null ? double.parse(miles) : 0.0;

    return showModalBottomSheet<void>(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return FilterBottomSheet(
          onTap: onTap,
          onReset: onReset!,
          initialDistance: helperDistance,
          initialRating: helperRating,
        );
      },
    );
  }
}
