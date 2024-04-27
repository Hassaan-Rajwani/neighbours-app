import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NearByLocation extends StatelessWidget {
  const NearByLocation({
    required this.onTap,
    required this.isLoading,
    super.key,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(gap: 10),
          Text(
            'Explore Nearby',
            style: TextStyle(
              fontFamily: interBold,
              fontSize: SizeHelper.moderateScale(16),
              color: Colors.black,
            ),
          ),
          const Gap(gap: 20),
          InkWell(
            onTap: isLoading ? null : onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeHelper.getDeviceWidth(70),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        currentLocationIcon,
                      ),
                      const Gap(
                        gap: 12,
                        axis: 'x',
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use current location',
                            style: TextStyle(
                              fontFamily: interBold,
                              fontSize: SizeHelper.moderateScale(16),
                              color: Colors.black,
                            ),
                          ),
                          const Gap(gap: 5),
                          Text(
                            'Add your address later',
                            style: TextStyle(
                              fontFamily: interRegular,
                              color: const Color(0xff4A4A4A),
                              fontSize: SizeHelper.moderateScale(14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    height: SizeHelper.moderateScale(20),
                    width: SizeHelper.moderateScale(20),
                    child: const CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
