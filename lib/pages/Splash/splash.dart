import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Neighbrs',
              style: TextStyle(
                fontFamily: ralewayExtrabold,
                fontSize: SizeHelper.moderateScale(30),
                color: codGray,
              ),
            ),
            const Gap(gap: 70),
            Center(child: Image.asset(splashImage)),
            const Gap(gap: 42),
            Text(
              'Neighbors Helping Neighbors',
              style: TextStyle(
                fontFamily: interRegular,
                fontSize: SizeHelper.moderateScale(20),
                color: codGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
