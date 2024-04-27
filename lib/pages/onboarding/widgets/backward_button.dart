import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class BackwardButton extends StatelessWidget {
  const BackwardButton({
    required this.onTap,
    required this.activePage,
    super.key,
  });

  final VoidCallback onTap;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: activePage == 0 ? null : onTap,
      child: Container(
        height: SizeHelper.moderateScale(60),
        width: SizeHelper.moderateScale(60),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.all(
            Radius.circular(
              SizeHelper.moderateScale(8),
            ),
          ),
        ),
        child: Icon(
          Icons.arrow_back,
          color: activePage > 0 ? Colors.black : const Color(0xFFCACACA),
        ),
      ),
    );
  }
}
