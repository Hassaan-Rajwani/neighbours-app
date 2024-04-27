import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class DropdownComponent extends StatelessWidget {
  const DropdownComponent({
    required this.value,
    required this.list,
    required this.onChange,
    required this.label,
    this.marginBottom = 20,
    super.key,
  });

  final String label;
  final dynamic value;
  final List<String> list;
  final double marginBottom;
  final dynamic Function(dynamic)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: SizeHelper.moderateScale(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: ralewaySemibold,
              fontSize: SizeHelper.moderateScale(12),
              color: codGray,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: marginBottom),
          decoration: BoxDecoration(
              color: athensGray,
              border: Border.all(
                color: const Color(0xFFECF0F3),
              ),
              borderRadius: BorderRadius.circular(8),),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeHelper.moderateScale(3),
              horizontal: 20,
            ),
            child: DropdownButton(
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconEnabledColor: const Color(0xFFD4DDE5),
              underline: const SizedBox(),
              value: value,
              items: list.map((list) {
                final checkList =
                    list.runtimeType == String || list.runtimeType == List;
                final data = checkList
                    ? list.runtimeType == List && list.length > 1
                        ? Text(
                            list[1],
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            list,
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                    : list;

                return DropdownMenuItem(
                  value: list,
                  child: checkList ? data as Widget : list as Widget,
                );
              }).toList(),
              onChanged: onChange,
            ),
          ),
        ),
      ],
    );
  }
}
