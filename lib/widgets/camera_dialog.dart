import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class CameraDialog extends StatelessWidget {
  const CameraDialog({
    required this.text,
    super.key,
    this.cameraOnPress,
    this.galleryOnPress,
  });

  final VoidCallback? cameraOnPress;
  final VoidCallback? galleryOnPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeHelper.moderateScale(194),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            SizeHelper.moderateScale(2),
          ),
          bottomRight: Radius.circular(
            SizeHelper.moderateScale(2),
          ),
          topLeft: Radius.circular(
            SizeHelper.moderateScale(25),
          ),
          topRight: Radius.circular(
            SizeHelper.moderateScale(25),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: SizeHelper.moderateScale(12),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    SizeHelper.moderateScale(50),
                  ),
                ),
                color: const Color(0xFF99C0C3),
              ),
              width: SizeHelper.moderateScale(69),
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeHelper.moderateScale(27),
                bottom: SizeHelper.moderateScale(5),
              ),
              child: Text(
                'Upload Picture',
                style: TextStyle(
                  color: const Color(0xFF214465),
                  fontSize: SizeHelper.moderateScale(16),
                  fontFamily: ralewayExtrabold,
                ),
              ),
            ),
            SizedBox(
              width: SizeHelper.moderateScale(342),
              child: Divider(
                thickness: SizeHelper.moderateScale(1),
                color: const Color(0xFFD9D9D9),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeHelper.moderateScale(22),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: galleryOnPress,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeHelper.moderateScale(20),
                      ),
                      child: SvgPicture.asset(
                        galleryIcon,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeHelper.moderateScale(10),
                      ),
                      child: Text(
                        'Choose From Gallery',
                        style: TextStyle(
                          color: const Color(0xFF214465),
                          fontSize: SizeHelper.moderateScale(14),
                          fontFamily: interMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: cameraOnPress,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeHelper.moderateScale(25),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeHelper.moderateScale(20),
                      ),
                      child: SvgPicture.asset(
                        cameraIcon,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeHelper.moderateScale(10),
                      ),
                      child: Text(
                        'Take A Photo',
                        style: TextStyle(
                          color: const Color(0xFF214465),
                          fontSize: SizeHelper.moderateScale(14),
                          fontFamily: interMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
