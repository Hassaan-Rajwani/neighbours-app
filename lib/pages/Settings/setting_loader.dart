import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class SettingLoader extends StatelessWidget {
  const SettingLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: SizeHelper.moderateScale(25),
        ),
        SizedBox(width: SizeHelper.moderateScale(15)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: SizeHelper.moderateScale(12),
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: dustyGray,
              ),
            ),
            const Gap(gap: 10),
            SizedBox(
              width: SizeHelper.getDeviceWidth(45),
              child: Text(
                'firstName',
                style: TextStyle(
                  fontSize: SizeHelper.moderateScale(16),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(15),
            vertical: SizeHelper.moderateScale(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            border: Border.all(
              width: SizeHelper.moderateScale(1),
            ),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: SizeHelper.moderateScale(12),
              color: Colors.black,
              fontFamily: ralewayMedium,
            ),
          ),
        ),
      ],
    );
  }
}
