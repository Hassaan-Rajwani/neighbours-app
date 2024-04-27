import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AddCards extends StatelessWidget {
  const AddCards({
    required this.onTap,
    required this.isLoading,
    super.key,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(gap: 95),
        SvgPicture.asset(
          addCard,
          height: SizeHelper.moderateScale(205),
        ),
        const Gap(gap: 35),
        Text(
          'No Cards',
          style: TextStyle(
            fontFamily: urbanistSemiBold,
            fontSize: SizeHelper.moderateScale(20),
            color: mineShaft,
          ),
        ),
        const Gap(gap: 12),
        Text(
          '''
In order to post a new job you need to add credit card details to transfer funds.''',
          style: TextStyle(
            fontFamily: urbanistRegular,
            fontSize: SizeHelper.moderateScale(14),
            color: doveGray,
            height: SizeHelper.moderateScale(2),
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(gap: 90),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(20),
            vertical: SizeHelper.moderateScale(50),
          ),
          child: AppButton(
            onPress: isLoading ? null : onTap,
            text: 'Add Card',
            horizontalMargin: 0,
            buttonLoader: isLoading,
          ),
        ),
      ],
    );
  }
}
