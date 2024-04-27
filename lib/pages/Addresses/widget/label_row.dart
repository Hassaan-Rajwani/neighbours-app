// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/pages/Addresses/widget/label_box.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AddressLabelRow extends StatefulWidget {
  AddressLabelRow({
    required this.selectedLabel,
    super.key,
  });

  String selectedLabel;

  @override
  State<AddressLabelRow> createState() => AddressLabelRowState();
}

class AddressLabelRowState extends State<AddressLabelRow> {
  final lableList = [
    {'label': 'Home', 'icon': 'assets/svgs/home.svg', 'showbar': false},
    {'label': 'Work', 'icon': 'assets/svgs/work.svg', 'showbar': true},
    {
      'label': 'Other',
      'icon': 'assets/svgs/labellocation.svg',
      'showbar': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      child: Column(
        children: [
          const Gap(gap: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: lableList.asMap().entries.map((entry) {
              final index = entry.key;
              final labelData = entry.value;
              return LabelBox(
                showBar: labelData['showbar']! as bool,
                label: labelData['label'].toString(),
                icon: labelData['icon'].toString(),
                bgColor:
                    checkAddressSelectedTabFromName(widget.selectedLabel) ==
                            index
                        ? cornflowerBlue
                        : Colors.white,
                lableColor:
                    checkAddressSelectedTabFromName(widget.selectedLabel) ==
                            index
                        ? Colors.white
                        : Colors.black,
                onTap: (tapIndex) async {
                  setState(() {
                    widget.selectedLabel = checkAddressSelectedTab(tapIndex);
                  });
                  await setDataToStorage(
                    StorageKeys.addressLable,
                    widget.selectedLabel,
                  );
                },
                index: index,
                textColor:
                    checkAddressSelectedTabFromName(widget.selectedLabel) ==
                            index
                        ? Colors.white
                        : const Color(0xff4A4A4A),
                iconColor:
                    checkAddressSelectedTabFromName(widget.selectedLabel) ==
                            index
                        ? Colors.white
                        : cornflowerBlue,
                barColor:
                    checkAddressSelectedTabFromName(widget.selectedLabel) ==
                            index
                        ? Colors.white
                        : Colors.grey,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
