import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class RatingBox extends StatelessWidget {
  const RatingBox({
    required this.rating,
    super.key,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(5),
        vertical: SizeHelper.moderateScale(2),
      ),
      decoration: BoxDecoration(
        color: cornflowerBlue,
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(4),
        ),
      ),
      child: Row(
        children: [
          Text(
            rating,
            style: TextStyle(
              fontSize: SizeHelper.moderateScale(10),
              fontFamily: urbanistSemiBold,
              color: Colors.white,
            ),
          ),
          const Gap(gap: 2, axis: 'x'),
          Icon(
            Icons.star_rate_rounded,
            color: Colors.white,
            size: SizeHelper.moderateScale(12),
          ),
        ],
      ),
    );
  }
}
