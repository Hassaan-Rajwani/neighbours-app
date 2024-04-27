// ignore_for_file: avoid_dynamic_calls, use_build_context_synchronously, deprecated_member_use, lines_longer_than_80_chars
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/data/models/address.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/package_job_icon_and_text.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NeighborPackageInfoAndAddress extends StatelessWidget {
  const NeighborPackageInfoAndAddress({
    required this.data,
    super.key,
  });

  final dynamic data;

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
                textAlign: TextAlign.left,
                data.title.toString(),
                style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(20),
                  color: codGray,
                ),
              ),
              const Gap(gap: 8),
              Text(
                textAlign: TextAlign.left,
                data.description.toString(),
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
                icon: data.type == 'RECURRING' ? recurringIcon : oneTimeIcon,
                heading: 'Job Type',
                text: data.type.toString().pascalCase,
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: persimmon.withOpacity(0.15),
                icon: packageIconTwo,
                heading: 'Type',
                text: data.pickupType.length == 1
                    ? data.pickupType[0].toString().pascalCase
                    : '''${data.pickupType[0].toString().pascalCase} & ${data.pickupType[1].toString().pascalCase}''',
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: casablanca.withOpacity(0.15),
                icon: sizeIcon,
                heading: 'Size',
                text: data.size[0].toString().pascalCase,
              ),
              PackageJobIconAndTextWidget(
                backgroundColor: olivine.withOpacity(0.15),
                icon: amountIcon,
                heading: r'$/Parcel',
                text: '\$${data.budget}',
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
                      data.address.streetName.toString(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: interBold,
                        fontSize: SizeHelper.moderateScale(16),
                        color: codGray,
                      ),
                    ),
                    const Gap(gap: 10),
                    Text(
                      formatedAddress(data.address as AddressModel),
                      style: TextStyle(
                        fontFamily: interRegular,
                        color: codGray,
                        fontSize: SizeHelper.moderateScale(14),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    final latLong =
                        '''${data.address.lat},${data.address.long}''';
                    final latLongList = latLong.split(',');
                    if (latLongList.length >= 2) {
                      final latitude = double.tryParse(latLongList[0]);
                      final longitude = double.tryParse(latLongList[1]);
                      if (latitude != null && longitude != null) {
                        final mapUrl =
                            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

                        if (await canLaunch(mapUrl)) {
                          await launch(mapUrl);
                        } else {
                          snackBarComponent(
                            context,
                            color: cinnabar,
                            message: 'Could not launch $mapUrl',
                          );
                        }
                      } else {
                        snackBarComponent(
                          context,
                          color: cinnabar,
                          message: 'Invalid Address',
                        );
                      }
                    } else {
                      snackBarComponent(
                        context,
                        color: cinnabar,
                        message: 'Invalid Address',
                      );
                    }
                  },
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
