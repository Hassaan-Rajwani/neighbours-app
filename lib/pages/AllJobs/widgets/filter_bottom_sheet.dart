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

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    required this.onTap,
    required this.onReset,
    this.initialRating = 0,
    this.initialDistance = 0.0,
    super.key,
  });
  final void Function(double, double)? onTap;
  final VoidCallback onReset;
  final double initialRating;
  final double initialDistance;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _value;
  late double ratingCount;

  @override
  void initState() {
    super.initState();
    ratingCount = widget.initialRating;
    _value = widget.initialDistance;
  }

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
      height: SizeHelper.getDeviceHeight(
        Platform.isAndroid ? 45 : 43,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: SizeHelper.moderateScale(150),
                  ),
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: gallery,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Text(
                          'Filters',
                          style: TextStyle(
                            fontFamily: interBold,
                            fontSize: SizeHelper.moderateScale(16),
                            color: codGray,
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: SizeHelper.moderateScale(20),
                ),
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
                child: Container(
                  padding: EdgeInsets.only(
                    left: SizeHelper.moderateScale(15),
                    top: SizeHelper.moderateScale(15),
                    bottom: SizeHelper.moderateScale(15),
                  ),
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
          const Gap(gap: 30),
          AppButton(
            onPress: () async {
              await setDataToStorage(
                StorageKeys.helperNeighbrRating,
                '$ratingCount',
              );
              await setDataToStorage(
                StorageKeys.helperNeighbrDistance,
                '$_value',
              );
              widget.onTap!(ratingCount, _value);
            },
            text: 'Apply Changes',
          ),
          const Gap(gap: 10),
        ],
      ),
    );
  }
}
