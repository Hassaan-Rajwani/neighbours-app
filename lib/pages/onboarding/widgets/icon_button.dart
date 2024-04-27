import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithGesture extends StatelessWidget {
  const IconWithGesture({
    required this.label,
    required this.onTap,
    super.key,
    this.svgAsset,
    this.iconColor,
    this.textColor,
  });

  final String? svgAsset; // Path to the SVG asset
  final String label;
  final void Function() onTap;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (svgAsset != null)
              SvgPicture.asset(
                svgAsset!,
                width: 24,
                height: 24,
                color: iconColor,
              ),
            if (svgAsset != null)
              const SizedBox(
                width: 15,
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
