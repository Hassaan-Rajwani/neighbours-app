// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:sizer/sizer.dart';

class SizeHelper {
  static int guidelineBaseWidth = 430;
  static int guidelineBaseHeight = 931;

  static double screenWidth = window.physicalSize.width;
  static double screenHeight = window.physicalSize.height;

  static double verticalScale(int size) {
    return screenHeight / guidelineBaseHeight * size;
  }

  static double moderateScale(int size, {double factor = 1}) {
    return double.parse((size / 1.255).toStringAsFixed(1)).sp;
  }

  static double getDeviceWidth(int size) {
    return double.parse(size.toString()).w;
  }

  static double getDeviceHeight(int size) {
    return double.parse(size.toString()).h;
  }
}
