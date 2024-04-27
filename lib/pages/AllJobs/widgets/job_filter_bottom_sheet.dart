import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/custome_slider.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/package_size_box.dart';

class JobFilterBottomSheet extends StatefulWidget {
  const JobFilterBottomSheet({
    required this.onTap,
    required this.onReset,
    this.jobFilterHelperDistance = 0.0,
    this.initialTipIndex = -1,
    this.initialSortIndex = -1,
    this.initialRating = 0,
    this.initialPickupTypeIndex = -1,
    super.key,
  });
  final void Function(double, int, int, int, double)? onTap;
  final VoidCallback onReset;
  final double jobFilterHelperDistance;
  final int initialTipIndex;
  final int initialSortIndex;
  final int initialPickupTypeIndex;
  final double initialRating;

  @override
  State<JobFilterBottomSheet> createState() => _JobFilterBottomSheetState();
}

class _JobFilterBottomSheetState extends State<JobFilterBottomSheet> {
  late double _value;
  late int _selectedTipIndex;
  late int _selectedSortIndex;
  late int _selectedPickupTypeIndex;
  late double ratingCount;

  @override
  void initState() {
    super.initState();
    _selectedTipIndex = widget.initialTipIndex;
    _selectedSortIndex = widget.initialSortIndex;
    _value = widget.jobFilterHelperDistance;
    ratingCount = widget.initialRating;
    _selectedPickupTypeIndex = widget.initialPickupTypeIndex;
  }

  final List<Map<String, dynamic>> tipData = [
    {
      'label': 'Small',
    },
    {
      'label': 'Medium',
    },
    {
      'label': 'Large',
    },
  ];

  final List<Map<String, dynamic>> sortData = [
    {
      'label': 'Latest First',
    },
    {
      'label': 'Oldest First',
    },
  ];

  final List<Map<String, dynamic>> pickupType = [
    {
      'label': 'Pickup',
    },
    {
      'label': 'Delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SizeHelper.moderateScale(16),
          ),
          topRight: Radius.circular(
            SizeHelper.moderateScale(16),
          ),
        ),
      ),
      height: SizeHelper.getDeviceHeight(Platform.isAndroid ? 80 : 75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: SizeHelper.moderateScale(20),
                  left: SizeHelper.moderateScale(170),
                ),
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  color: gallery,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: SizeHelper.moderateScale(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: SizeHelper.moderateScale(7),
                        ),
                        child: Text(
                          'Filters',
                          style: TextStyle(
                            fontFamily: interBold,
                            fontSize: SizeHelper.moderateScale(16),
                            color: codGray,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onReset,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontFamily: interBold,
                          fontSize: SizeHelper.moderateScale(16),
                          color: cornflowerBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 30),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Rating',
                        style: TextStyle(
                          fontFamily: interMedium,
                          fontSize: SizeHelper.moderateScale(14),
                          color: doveGray,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        child: RatingBar.builder(
                          initialRating: ratingCount,
                          unratedColor: Colors.grey,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratingCount = rating;
                            });
                          },
                          updateOnDrag: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 10),
              Container(
                padding: EdgeInsets.only(
                  top: SizeHelper.moderateScale(10),
                  left: SizeHelper.moderateScale(20),
                ),
                child: Text(
                  'Distance',
                  style: TextStyle(
                    fontFamily: interMedium,
                    fontSize: SizeHelper.moderateScale(14),
                    color: doveGray,
                  ),
                ),
              ),
              CustomSlider(
                value: _value,
                onChanged: (double valueValue) {
                  setState(() {
                    _value = valueValue;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0.1 mile',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(10),
                        color: codGray,
                      ),
                    ),
                    Text(
                      '0.9 mile',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(10),
                        color: codGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 20),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Package Size',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(14),
                        color: doveGray,
                      ),
                    ),
                    const Gap(gap: 5),
                    Row(
                      children: tipData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final itemData = entry.value;

                        final isFirstIndex = index == 0;
                        final isLastIndex = index == tipData.length - 1;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTipIndex = index;
                            });
                          },
                          child: PackageBox(
                            tipLabel: itemData['label'] as String,
                            isSelected: _selectedTipIndex == index,
                            isFirstIndex: isFirstIndex,
                            isLastIndex: isLastIndex,
                          ),
                        );
                      }).toList(),
                    ),
                    const Gap(gap: 15),
                    Text(
                      'Sort By',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(14),
                        color: doveGray,
                      ),
                    ),
                    const Gap(gap: 5),
                    Row(
                      children: sortData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final itemData = entry.value;

                        final isFirstIndex = index == 0;
                        final isLastIndex = index == 1;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSortIndex = index;
                            });
                          },
                          child: PackageBox(
                            tipLabel: itemData['label'] as String,
                            isSelected: _selectedSortIndex == index,
                            isFirstIndex: isFirstIndex,
                            isLastIndex: isLastIndex,
                          ),
                        );
                      }).toList(),
                    ),
                    const Gap(gap: 15),
                    Text(
                      'Delivery Mode',
                      style: TextStyle(
                        fontFamily: interMedium,
                        fontSize: SizeHelper.moderateScale(14),
                        color: doveGray,
                      ),
                    ),
                    const Gap(gap: 5),
                    Row(
                      children: pickupType.asMap().entries.map((entry) {
                        final index = entry.key;
                        final itemData = entry.value;

                        final isFirstIndex = index == 0;
                        final isLastIndex = index == 1;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPickupTypeIndex = index;
                            });
                          },
                          child: PackageBox(
                            tipLabel: itemData['label'] as String,
                            isSelected: _selectedPickupTypeIndex == index,
                            isFirstIndex: isFirstIndex,
                            isLastIndex: isLastIndex,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 30),
            ],
          ),
          AppButton(
            onPress: () async {
              await setDataToStorage(StorageKeys.jobSize, '$_selectedTipIndex');
              await setDataToStorage(
                StorageKeys.jobSorting,
                '$_selectedSortIndex',
              );
              await setDataToStorage(
                StorageKeys.jobRating,
                '$ratingCount',
              );
              await setDataToStorage(
                StorageKeys.jobPickupType,
                '$_selectedPickupTypeIndex',
              );
              await setDataToStorage(StorageKeys.jobDistance, '$_value');
              widget.onTap!(
                _value,
                _selectedTipIndex,
                _selectedSortIndex,
                _selectedPickupTypeIndex,
                ratingCount,
              );
            },
            text: 'Apply Changes',
          ),
          const Gap(gap: 10),
        ],
      ),
    );
  }
}
