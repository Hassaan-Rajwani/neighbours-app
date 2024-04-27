import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class NoInternetSplash extends StatelessWidget {
  const NoInternetSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(135),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              nointernet,
              height: SizeHelper.moderateScale(150),
            ),
            Text(
              'No Internet',
              style: TextStyle(
                fontFamily: urbanistSemiBold,
                fontSize: SizeHelper.moderateScale(20),
                color: mineShaft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
