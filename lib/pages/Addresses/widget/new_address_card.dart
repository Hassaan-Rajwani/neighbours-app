// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NewAddressCard extends StatelessWidget {
  const NewAddressCard({
    required this.isDefault,
    required this.onEdit,
    required this.onDelete,
    required this.text1,
    required this.text2,
    super.key,
  });

  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(gap: 10),
        Container(
          padding: EdgeInsets.fromLTRB(
            SizeHelper.moderateScale(20),
            SizeHelper.moderateScale(15),
            SizeHelper.moderateScale(20),
            SizeHelper.moderateScale(15),
          ),
          color: isDefault ? cornflowerBlue : athensGray,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeHelper.getDeviceWidth(isDefault ? 80 : 75),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      color: isDefault ? Colors.white : Colors.black,
                      height: 25,
                    ),
                    const Gap(
                      gap: 12,
                      axis: 'x',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeHelper.getDeviceWidth(65),
                          child: Text(
                            text1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: interBold,
                              fontSize: SizeHelper.moderateScale(16),
                              color: isDefault ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        const Gap(gap: 10),
                        Text(
                          text2,
                          style: TextStyle(
                            fontFamily: interRegular,
                            color: isDefault ? Colors.white : Colors.black,
                            fontSize: SizeHelper.moderateScale(14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeHelper.moderateScale(15),
                ),
                child: Row(
                  children: [
                    if (isDefault)
                      Column(
                        children: [
                          InkWell(
                            onTap: onEdit,
                            child: SvgPicture.asset(
                              editprofileIcon,
                              height: SizeHelper.moderateScale(20),
                              width: SizeHelper.moderateScale(20),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          InkWell(
                            onTap: onEdit,
                            child: SvgPicture.asset(
                              editprofileIcon,
                              color: isDefault ? Colors.white : Colors.black,
                              height: SizeHelper.moderateScale(20),
                              width: SizeHelper.moderateScale(20),
                            ),
                          ),
                          const Gap(
                            gap: 10,
                            axis: 'x',
                          ),
                          InkWell(
                            onTap: onDelete,
                            child: SvgPicture.asset(
                              deleteIcon,
                              color: isDefault ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
