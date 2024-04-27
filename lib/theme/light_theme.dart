// ignore_for_file: unnecessary_parenthesis

import 'package:flutter/material.dart';
import 'package:neighbour_app/theme/extensions/custom_theme_extension.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

ThemeData lightTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    extensions: [CustomThemeExtension.lightMode],
    elevatedButtonTheme: (ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cornflowerBlue,
        foregroundColor: cornflowerBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(30),
          ),
        ),
      ),
    )),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
