import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/pages/Helper/helper.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HomeNearbyBanner extends StatelessWidget {
  const HomeNearbyBanner({
    super.key,
    this.isHelper = false,
    this.isNavigate = true,
  });
  final bool isHelper;
  final bool isNavigate;

  @override
  Widget build(BuildContext context) {
    final userType = isHelper ? 'Neighbors!' : 'Helpers';
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      padding: EdgeInsets.only(
        top: SizeHelper.moderateScale(15),
      ),
      width: double.maxFinite,
      height: SizeHelper.moderateScale(210),
      decoration: BoxDecoration(
        color: cornflowerBlue,
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 5,
            right: 8,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Image.asset(nearbyBannerImage),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeHelper.moderateScale(20),
            ),
            alignment: Alignment.center,
            width: SizeHelper.getDeviceWidth(isHelper ? 100 : 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(20),
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: isHelper
                              ? 'Thanks for helping your\n'
                              : 'Nearby\n',
                        ),
                        TextSpan(
                          text: userType,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: interBold,
                            fontWeight: FontWeight.w900,
                            fontSize: SizeHelper.moderateScale(30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(gap: 10),
                if (!isHelper)
                  GestureDetector(
                    onTap: () {
                      if (isNavigate) {
                        context.pushReplacement(HelperPage.routeName);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeHelper.moderateScale(5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          SizeHelper.moderateScale(58),
                        ),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Find $userType',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
