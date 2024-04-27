import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AppButtonSmall extends StatelessWidget {
  const AppButtonSmall({
    required this.text,
    required this.btnColor,
    required this.textColor,
    required this.onPress,
    required this.isSelected,
    this.image,
    super.key,
    this.imageColor,
    this.imageSize,
    this.isImage = true,
    this.isBorder = true,
  });
  final String text;
  final Color btnColor;
  final String? image;
  final Color? imageColor;
  final Color textColor;
  final double? imageSize;
  final VoidCallback onPress;
  final bool isImage;
  final bool isBorder;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: isSelected
            ? EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(15),
                vertical: SizeHelper.moderateScale(
                  15,
                ),
              )
            : EdgeInsets.symmetric(
                horizontal: SizeHelper.moderateScale(5),
                vertical: SizeHelper.moderateScale(
                  15,
                ),
              ),
        decoration: BoxDecoration(
          color: btnColor,
          border: isBorder ? Border.all(color: cornflowerBlue) : const Border(),
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(
              8,
            ),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeHelper.moderateScale(20),
                child: isImage == true
                    ? SvgPicture.asset(
                        image!,
                        color: imageColor,
                        height: imageSize,
                      )
                    : Container(),
              ),
              const Gap(
                gap: 2,
                axis: 'x',
              ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: isImage == true ? nunitoMedium : interBold,
                  fontWeight: FontWeight.w700,
                  fontSize: isImage == true
                      ? SizeHelper.moderateScale(8)
                      : SizeHelper.moderateScale(14),
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
