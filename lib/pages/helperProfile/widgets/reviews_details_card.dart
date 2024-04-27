import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/rating_box.dart';

class ReviewsDetalsCard extends StatelessWidget {
  const ReviewsDetalsCard({
    required this.name,
    required this.dateAndTime,
    required this.review,
    required this.rate,
    super.key,
  });

  final String name;
  final String dateAndTime;
  final String review;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: SizeHelper.moderateScale(20),
        right: SizeHelper.moderateScale(20),
        bottom: SizeHelper.moderateScale(15),
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(8),
          ),
          border: Border.all(color: codGray, width: 0.1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(20),
            vertical: SizeHelper.moderateScale(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: codGray,
                          fontFamily: ralewayBold,
                          fontSize: SizeHelper.moderateScale(14),
                        ),
                      ),
                      const Gap(gap: 5),
                      Text(
                        extractDateAndTime(dateAndTime),
                        style: TextStyle(
                          color: doveGray,
                          fontFamily: interMedium,
                          fontSize: SizeHelper.moderateScale(12),
                        ),
                      ),
                    ],
                  ),
                  RatingBox(rating: rate),
                ],
              ),
              const Gap(gap: 15),
              Text(
                review,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: darkGray,
                  fontFamily: interRegular,
                  fontSize: SizeHelper.moderateScale(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
