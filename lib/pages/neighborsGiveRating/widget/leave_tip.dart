import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class LeaveTipSelection extends StatelessWidget {
  const LeaveTipSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final helperProfileInfo = <String, dynamic>{
      'name': 'Michael Scott',
      'image': profileTwo,
      'rating': '4.5/5',
      'jobsDone': '150',
      'amount': r'$100',
      'unreadMessages': '4',
    };
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeHelper.moderateScale(20),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(
              16,
            ),
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: SizeHelper.moderateScale(50),
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: SizeHelper.moderateScale(45),
                backgroundImage: AssetImage(profileTwo),
              ),
            ),
            Text(
              helperProfileInfo['name'] as String,
              style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(16),
                  color: codGray,),
            ),
            const Gap(gap: 10),
            Text(
              'Give Feedback. It will improve our\nApp Experience',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: interRegular,
                  color: doveGray,
                  height: 2,
                  fontSize: SizeHelper.moderateScale(14),),
            ),
          ],
        ),
      ),
    );
  }
}
