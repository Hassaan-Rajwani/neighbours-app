// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    required this.address,
    required this.location,
    required this.selected,
    super.key,
    this.onEditTap,
    this.onDeleteTap,
  });
  final String address;
  final String location;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? cornflowerBlue : Colors.grey,
            width: 0.5,
          ),
          color: selected ? cornflowerBlue.withOpacity(0.10) : Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: selected
                  ? EdgeInsets.only(
                      left: SizeHelper.moderateScale(10),
                      right: SizeHelper.moderateScale(10),
                      bottom: SizeHelper.moderateScale(10),
                      top: SizeHelper.moderateScale(10),
                    )
                  : EdgeInsets.only(
                      left: SizeHelper.moderateScale(10),
                      right: SizeHelper.moderateScale(10),
                      bottom: SizeHelper.moderateScale(20),
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: selected
                              ? SizeHelper.moderateScale(38)
                              : SizeHelper.moderateScale(10),
                        ),
                        child: SvgPicture.asset(locationIcon),
                      ),
                      SizedBox(width: SizeHelper.moderateScale(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: selected
                                ? EdgeInsets.only(
                                    bottom: SizeHelper.moderateScale(15),
                                  )
                                : EdgeInsets.only(
                                    top: SizeHelper.moderateScale(15),
                                  ),
                            child: SizedBox(
                              width: SizeHelper.getDeviceWidth(60),
                              child: Text(
                                address,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: SizeHelper.moderateScale(16),
                                  fontFamily: interBold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          if (!selected) const Gap(gap: 15),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: selected
                                  ? SizeHelper.moderateScale(15)
                                  : SizeHelper.moderateScale(0),
                            ),
                            child: Text(
                              location,
                              style: TextStyle(
                                fontSize: SizeHelper.moderateScale(14),
                                color: doveGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (selected)
                        Row(
                          children: [
                            SvgPicture.asset(greenTick),
                          ],
                        ),
                      if (selected)
                        SizedBox(height: SizeHelper.moderateScale(20))
                      else
                        Container(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: onEditTap,
                            child: SvgPicture.asset(
                              editprofileIcon,
                              color: Colors.blue,
                              height: SizeHelper.moderateScale(20),
                              width: SizeHelper.moderateScale(20),
                            ),
                          ),
                          const Gap(
                            gap: 10,
                            axis: 'x',
                          ),
                          GestureDetector(
                            onTap: onDeleteTap,
                            child: SvgPicture.asset(
                              deleteIcon,
                            ),
                          ),
                        ],
                      ),
                    ],
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
