// ignore_for_file: lines_longer_than_80_chars, deprecated_member_use, file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/gap.dart';

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({
    required this.floor,
    required this.house,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.formKey,
    required this.floorData,
    required this.labels,
    required this.houseData,
    required this.streetData,
    super.key,
  });

  final TextEditingController street;
  final TextEditingController house;
  final TextEditingController floor;
  final TextEditingController city;
  final TextEditingController postalCode;
  final TextEditingController state;
  final String houseData;
  final String floorData;
  final String streetData;
  final Widget labels;
  final Key formKey;

  @override
  State<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyboardDismissle(context: context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(20),
        ),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                height: SizeHelper.moderateScale(5),
                width: SizeHelper.moderateScale(40),
                decoration: const BoxDecoration(
                  color: gallery,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              const Gap(gap: 20),
              const Row(
                children: [
                  Text(
                    'Add a new address',
                    style: TextStyle(
                      fontFamily: interBold,
                      fontSize: 14,
                      color: mineShaft,
                    ),
                  ),
                ],
              ),
              const Gap(gap: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: SizeHelper.moderateScale(15),
                        ),
                        // color: Colors.red,
                        child: SvgPicture.asset(
                          locationIcon,
                          color: cornflowerBlue,
                        ),
                      ),
                      const Gap(
                        gap: 15,
                        axis: 'x',
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeHelper.getDeviceWidth(70),
                            child: Text(
                              widget.houseData,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: SizeHelper.moderateScale(16),
                                fontFamily: interBold,
                                color: mineShaft,
                              ),
                            ),
                          ),
                          const Gap(
                            gap: 6,
                          ),
                          SizedBox(
                            width: SizeHelper.getDeviceWidth(70),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${widget.streetData} ',
                                    style: TextStyle(
                                      color: mineShaft,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: SizeHelper.moderateScale(14),
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.floorData,
                                    style: TextStyle(
                                      color: mineShaft,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: SizeHelper.moderateScale(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          height: SizeHelper.moderateScale(24),
                          editprofileIcon,
                          color: cornflowerBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(gap: 20),
              AppInput(
                placeHolder: 'Text here',
                label: 'Street name',
                horizontalMargin: 0,
                controller: widget.street,
                validator: ProjectRegex.streetValidator,
              ),
              AppInput(
                placeHolder: 'Text here',
                label: 'Unit number (Optional)',
                horizontalMargin: 0,
                controller: widget.floor,
              ),
              AppInput(
                placeHolder: 'Text here',
                label: 'City',
                horizontalMargin: 0,
                controller: widget.city,
                validator: ProjectRegex.cityValidator,
              ),
              AppInput(
                placeHolder: 'Text here',
                label: 'State',
                horizontalMargin: 0,
                controller: widget.state,
                validator: ProjectRegex.stateValidator,
              ),
              AppInput(
                placeHolder: 'Text here',
                label: 'Zip code',
                horizontalMargin: 0,
                controller: widget.postalCode,
                validator: ProjectRegex.zipValidator,
                keyboardType: TextInputType.number,
                maxLenght: 5,
              ),
              const Gap(gap: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add a Label',
                  style: TextStyle(
                    fontFamily: interBold,
                    fontSize: SizeHelper.moderateScale(12),
                    color: mineShaft,
                  ),
                ),
              ),
              const Gap(gap: 15),
              widget.labels,
            ],
          ),
        ),
      ),
    );
  }
}
