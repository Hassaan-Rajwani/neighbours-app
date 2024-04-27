import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}
