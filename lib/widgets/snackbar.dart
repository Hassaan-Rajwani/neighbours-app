// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/size_helper.dart';

ScaffoldFeatureController snackBarComponent(
  BuildContext context, {
  required Color color,
  required String message,
  bool? floating = false,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      backgroundColor: color,
      behavior: floating! ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(
        message,
        style: TextStyle(
          fontSize: SizeHelper.moderateScale(16),
          color: Colors.white,
          fontFamily: 'PoppinsRegular',
        ),
      ),
    ),
  );
}
