// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class FloatingButton extends StatefulWidget {
  FloatingButton({
    required this.toggle,
    required this.onTap,
    super.key,
  });

  bool toggle = false;
  final VoidCallback onTap;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          height: SizeHelper.moderateScale(60),
          width: SizeHelper.moderateScale(60),
          margin: EdgeInsets.only(
            bottom: SizeHelper.moderateScale(0),
          ),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (!widget.toggle == true) {
                  widget.onTap();
                }
                widget.toggle = !widget.toggle;
              });
            },
            elevation: 2,
            backgroundColor: Colors.black,
            child: widget.toggle
                ? Icon(
                    Icons.close,
                    size: SizeHelper.moderateScale(35),
                  )
                : SvgPicture.asset(
                    giftIcon,
                    height: SizeHelper.moderateScale(28),
                    width: SizeHelper.moderateScale(28),
                  ),
          ),
        );
      },
    );
  }
}
