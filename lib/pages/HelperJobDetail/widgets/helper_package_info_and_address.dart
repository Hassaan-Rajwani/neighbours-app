import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/package_job_icon_and_text.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelperPackageInfoAndAddress extends StatelessWidget {
  const HelperPackageInfoAndAddress({
    required this.packageName,
    required this.description,
    required this.jobType,
    required this.pickupType,
    required this.size,
    required this.amount,
    required this.address,
    required this.address1,
    required this.onPinTap,
    required this.typeIcon,
    super.key,
  });

  final String packageName;
  final String description;
  final String jobType;
  final String pickupType;
  final String size;
  final String amount;
  final String address;
  final String address1;
  final String typeIcon;
  final VoidCallback onPinTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. description
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(
              20,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                packageName,
                style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(20),
                  color: codGray,
                ),
              ),
              const Gap(gap: 8),
              Text(
                textAlign: TextAlign.left,
                description,
                style: TextStyle(
                  fontFamily: interRegular,
                  fontSize: SizeHelper.moderateScale(14),
                  height: 1.7,
                  letterSpacing: 0.14,
                  color: doveGray,
                ),
              ),
            ],
          ),
        ),

        const Gap(gap: 20),
        // 2. type and other info
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(
              20,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PackageJobIconAndTextWidget(
                backgroundColor: cornflowerBlue.withOpacity(0.15),
                icon: typeIcon,
                heading: 'Job Type',
                text: jobType,
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: persimmon.withOpacity(0.15),
                icon: packageIconTwo,
                heading: 'Type',
                text: pickupType,
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: casablanca.withOpacity(0.15),
                icon: sizeIcon,
                heading: 'Size',
                text: size,
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: olivine.withOpacity(0.15),
                icon: amountIcon,
                heading: r'$/Parcel',
                text: '\$$amount',
              ),
            ],
          ),
        ),
        const Gap(gap: 30),
        // address
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(
              20,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(SizeHelper.moderateScale(15)),
            decoration: BoxDecoration(
              color: dinGray,
              borderRadius: BorderRadius.circular(
                SizeHelper.moderateScale(
                  16,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(addressIcon),
                        const Gap(
                          gap: 15,
                          axis: 'x',
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontFamily: interSemibold,
                            fontSize: SizeHelper.moderateScale(14),
                            color: codGray,
                          ),
                        ),
                      ],
                    ),
                    const Gap(gap: 10),
                    Text(
                      address.trim(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: interBold,
                        fontSize: SizeHelper.moderateScale(16),
                        color: codGray,
                      ),
                    ),
                    const Gap(gap: 10),
                    Text(
                      address1.trim(),
                      style: TextStyle(
                        fontFamily: interRegular,
                        color: codGray,
                        fontSize: SizeHelper.moderateScale(14),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: onPinTap,
                  child: SvgPicture.asset(googleMapIcon),
                ),
              ],
            ),
          ),
        ),
        const Gap(gap: 10),
      ],
    );
  }
}
