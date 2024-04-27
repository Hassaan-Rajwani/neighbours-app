// ignore_for_file: avoid_positional_boolean_parameters
import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class RatingStars extends StatelessWidget {
  const RatingStars(
    this.rating, {
    super.key,
  });
  final double rating;

  Widget buildStar(bool isFilled) {
    return Icon(
      isFilled ? Icons.star : Icons.star_border,
      color: isFilled ? casablanca : Colors.grey,
      size: SizeHelper.moderateScale(15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return buildStar(index < rating);
      }),
    );
  }
}
