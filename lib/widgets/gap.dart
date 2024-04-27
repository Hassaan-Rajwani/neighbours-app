import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class Gap extends StatelessWidget {
  const Gap({
    required this.gap,
    super.key,
    this.axis = 'y',
  });

  final int gap;
  final String? axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeHelper.moderateScale(axis == 'y' ? gap : 0),
      width: SizeHelper.moderateScale(axis == 'x' ? gap : 0),
    );
  }
}
