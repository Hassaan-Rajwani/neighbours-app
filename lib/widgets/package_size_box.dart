import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class PackageBox extends StatefulWidget {
  const PackageBox({
    required this.tipLabel,
    required this.isSelected,
    required this.isFirstIndex,
    required this.isLastIndex,
    // required this.isSecondIndex,
    super.key,
  });

  final String tipLabel;
  final bool isSelected;
  final bool isFirstIndex;
  final bool isLastIndex;
  // final bool isSecondIndex;

  @override
  State<PackageBox> createState() => _PackageBoxState();
}

class _PackageBoxState extends State<PackageBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: SizeHelper.moderateScale(110),
        height: SizeHelper.moderateScale(46),
        padding: EdgeInsets.symmetric(
          vertical: SizeHelper.moderateScale(14),
        ),
        decoration: BoxDecoration(
            color: widget.isSelected ? cornflowerBlue : Colors.white,
            border: Border(
                top: Divider.createBorderSide(context, width: 1),
                bottom: Divider.createBorderSide(context, width: 1),
                left: Divider.createBorderSide(context, width: 1),
                right: Divider.createBorderSide(context, width: 1),),
            borderRadius: widget.isFirstIndex
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(SizeHelper.moderateScale(8)),
                    topLeft: Radius.circular(SizeHelper.moderateScale(8)),
                  )
                : widget.isLastIndex
                    ? BorderRadius.only(
                        topRight: Radius.circular(SizeHelper.moderateScale(8)),
                        bottomRight:
                            Radius.circular(SizeHelper.moderateScale(8)),)
                    : null,),
        child: Text(
          widget.tipLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: ralewaySemibold,
            fontSize: SizeHelper.moderateScale(12),
            color: widget.isSelected ? Colors.white : codGray,
          ),
        ),
      ),
    );
  }
}
