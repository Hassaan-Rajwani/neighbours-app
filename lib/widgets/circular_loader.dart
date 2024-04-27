import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({
    this.color,
    super.key,
    this.backgroundColor = Colors.white,
    this.height = 100,
  });
  final int? color;
  final int height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: SizeHelper.getDeviceHeight(height),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation(Colors.white),
          backgroundColor: color == null ? cornflowerBlue : Color(color!),
        ),
      ),
    );
  }
}
