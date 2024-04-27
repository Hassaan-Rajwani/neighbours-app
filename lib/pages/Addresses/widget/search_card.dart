// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    required this.onTap,
    required this.text,
    required this.state,
    required this.isLoading,
    super.key,
  });

  final VoidCallback onTap;
  final String text;
  final String state;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(
                SizeHelper.moderateScale(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeHelper.getDeviceWidth(70),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          locationIcon,
                          color: cornflowerBlue,
                          height: 25,
                        ),
                        const Gap(
                          gap: 12,
                          axis: 'x',
                        ),
                        SizedBox(
                          width: SizeHelper.getDeviceWidth(60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: interBold,
                                  fontSize: SizeHelper.moderateScale(16),
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(gap: 10),
                              Text(
                                state,
                                style: TextStyle(
                                  fontFamily: interRegular,
                                  color: Colors.black,
                                  fontSize: SizeHelper.moderateScale(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeHelper.moderateScale(10),
                      ),
                      height: SizeHelper.moderateScale(20),
                      width: SizeHelper.moderateScale(20),
                      child: const CircularProgressIndicator(),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeHelper.moderateScale(10),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
