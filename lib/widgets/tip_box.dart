import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class TipBox extends StatefulWidget {
  const TipBox({
    required this.tipLabel,
    required this.isSelected,
    required this.tipBox,
    this.image,
    super.key,
  });
  final String tipLabel;
  final bool isSelected;
  final bool tipBox;
  final String? image;

  @override
  State<TipBox> createState() => _TipBoxState();
}

class _TipBoxState extends State<TipBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: SizeHelper.moderateScale(5)),
        padding: EdgeInsets.symmetric(
          vertical: SizeHelper.moderateScale(15),
          horizontal: SizeHelper.moderateScale(12),
        ),
        decoration: widget.tipBox
            ? BoxDecoration(
                color: widget.isSelected ? cornflowerBlue : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: widget.isSelected ? cornflowerBlue : cornflowerBlue,
                ),
              )
            : BoxDecoration(
                color: widget.isSelected ? cornflowerBlue : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: widget.isSelected ? cornflowerBlue : baliHai,
                ),
              ),
        child: Row(
          children: [
            if (widget.tipBox)
              SvgPicture.asset(
                widget.image ?? '',
                width: SizeHelper.moderateScale(4),
                height: SizeHelper.moderateScale(24),
              )
            else
              Container(),
            const Gap(
              gap: 10,
              axis: 'x',
            ),
            if (widget.tipBox)
              Text(
                widget.tipLabel,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: SizeHelper.moderateScale(10),
                  color: widget.isSelected ? Colors.white : cornflowerBlue,
                ),
                textAlign: TextAlign.center,
              )
            else
              Text(
                widget.tipLabel,
                style: TextStyle(
                  fontFamily: ralewaySemibold,
                  fontSize: SizeHelper.moderateScale(14),
                  color: widget.isSelected ? Colors.white : baliHai,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
