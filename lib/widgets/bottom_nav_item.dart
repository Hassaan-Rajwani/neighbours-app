import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.currentIndex,
    required this.index,
    required this.icon,
    required this.name,
    super.key,
  });

  final Widget icon;
  final String name;
  final int currentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          width: SizeHelper.moderateScale(65),
          padding: EdgeInsets.all(SizeHelper.moderateScale(10)),
          child: icon,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: currentIndex == index ? cornflowerBlue : inactiveGray,
            fontSize: SizeHelper.moderateScale(12),
            fontFamily: 'PoppinsRegular',
          ),
        ),
        const Gap(gap: 5),
        if (currentIndex == index)
          CircleAvatar(
            radius: SizeHelper.moderateScale(2),
            backgroundColor: cornflowerBlue,
          ),
      ],
    );
  }
}
