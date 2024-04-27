import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class FiltersBox extends StatefulWidget {
  const FiltersBox({
    required this.svgIconPath,
    required this.label,
    this.height,
    this.width,
    super.key,
  });
  final String svgIconPath;
  final double? width;
  final double? height;
  final String label;

  @override
  State<FiltersBox> createState() => _FiltersBoxState();
}

class _FiltersBoxState extends State<FiltersBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.only(right: SizeHelper.moderateScale(10)),
        padding: EdgeInsets.symmetric(
          vertical: SizeHelper.moderateScale(10),
          horizontal: SizeHelper.moderateScale(10),
        ),
        decoration: const BoxDecoration(
          color: blizzardBlue,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              widget.svgIconPath,
              width: SizeHelper.moderateScale(15),
              height: SizeHelper.moderateScale(15),
            ),
            const Gap(
              gap: 05,
              axis: 'x',
            ),
            Text(
              widget.label,
              style: const TextStyle(
                fontFamily: interMedium,
                fontSize: 10,
                color: mineShaft,
              ),
            ),
            const Gap(gap: 05),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: SizeHelper.moderateScale(12),
            ),
          ],
        ),
      ),
    );
  }
}
