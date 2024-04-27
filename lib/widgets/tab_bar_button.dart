import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    required this.tabLabels,
    required this.initialTab,
    required this.onTap,
    super.key,
  });
  final List<String> tabLabels;
  final String initialTab;
  final void Function(String?)? onTap;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  Widget tabBarItem(String text) {
    return GestureDetector(
      onTap: () {
        widget.onTap!(text);
      },
      child: Container(
        alignment: Alignment.center,
        height: SizeHelper.moderateScale(50),
        width: SizeHelper.getDeviceWidth(43) + SizeHelper.moderateScale(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
          color: widget.initialTab == text ? Colors.black : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'interBold',
            color: widget.initialTab == text ? Colors.white : baliHai,
            fontSize: SizeHelper.moderateScale(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeHelper.moderateScale(50),
      width: SizeHelper.getDeviceWidth(87),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(SizeHelper.moderateScale(8)),
      ),
      child: Row(
        children: widget.tabLabels.map(tabBarItem).toList(),
      ),
    );
  }
}
