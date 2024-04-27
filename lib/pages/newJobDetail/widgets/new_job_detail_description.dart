// ignore_for_file: use_late_for_private_fields_and_variables, unused_field, use_named_constants, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/enum_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/image_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NewJobDetailDescription extends StatefulWidget {
  const NewJobDetailDescription({
    required this.title,
    required this.description,
    required this.distance,
    required this.type,
    required this.pickupType,
    required this.size,
    required this.budget,
    required this.lat,
    required this.long,
    super.key,
  });
  final String title;
  final String description;
  final String distance;
  final String type;
  final String pickupType;
  final String size;
  final String budget;
  final String lat;
  final String long;

  @override
  State<NewJobDetailDescription> createState() =>
      _NewJobDetailDescriptionState();
}

class _NewJobDetailDescriptionState extends State<NewJobDetailDescription> {
  GoogleMapController? _controller;
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      platformChecker(
        mapMarkerTwo,
        mapMarkerTwoIos,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final descData = <Map<String, dynamic>>[
      {
        'icon': widget.type == jobType.RECURRING.name
            ? jobDetailDescRecuring
            : jobDetailsDescOneTime,
        'text': widget.type,
        'textColor': codGray,
      },
      {
        'icon': jobDetailDescPickup,
        'text': widget.pickupType,
        'textColor': codGray,
      },
      {
        'icon': jobDetailDescWeight,
        'text': widget.size,
        'textColor': codGray,
      },
      {
        'icon': jobDetailDescCost,
        'text': '\$${widget.budget}',
        'textColor': olivine,
      }
    ];
    final circles = <Circle>{
      Circle(
        circleId: const CircleId(''),
        center: LatLng(
          double.parse(widget.lat),
          double.parse(widget.long),
        ),
        radius: 40,
        fillColor: emerald.withOpacity(0.5),
        strokeWidth: 1,
      ),
    };

    final cameraPosition = CameraPosition(
      target: LatLng(
        double.parse(widget.lat),
        double.parse(widget.long),
      ),
      zoom: 18,
    );

    return Container(
      width: SizeHelper.getDeviceWidth(100),
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(
          20,
        ),
        vertical: SizeHelper.moderateScale(
          25,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SizeHelper.moderateScale(
              16,
            ),
          ),
          topRight: Radius.circular(
            SizeHelper.moderateScale(
              16,
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Package Pickup Job
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(15),
                  vertical: SizeHelper.moderateScale(18),
                ),
                decoration: BoxDecoration(
                  color: cornflowerBlue,
                  borderRadius:
                      BorderRadius.circular(SizeHelper.moderateScale(16)),
                ),
                child: SizedBox(
                  height: SizeHelper.moderateScale(24),
                  width: SizeHelper.moderateScale(30),
                  child: SvgPicture.asset(
                    jobDetailPackage,
                  ),
                ),
              ),
              const Gap(gap: 20, axis: 'x'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: codGray,
                      fontFamily: ralewayBold,
                      fontSize: SizeHelper.moderateScale(16),
                    ),
                  ),
                  const Gap(gap: 10),
                  Text(
                    widget.distance,
                    style: TextStyle(
                      color: cornflowerBlue,
                      fontFamily: interMedium,
                      fontSize: SizeHelper.moderateScale(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(gap: 20),
          Text(
            'Description',
            style: TextStyle(
              fontFamily: ralewayBold,
              color: codGray,
              fontSize: SizeHelper.moderateScale(16),
            ),
          ),
          const Gap(gap: 8),
          Text(
            widget.description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              height: 1.85,
              fontFamily: interRegular,
              color: doveGray,
              letterSpacing: 0.12,
            ),
          ),
          const Gap(gap: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: descData.asMap().entries.map((entry) {
              final item = entry.value;
              return Container(
                alignment: Alignment.center,
                height: SizeHelper.moderateScale(100),
                width: SizeHelper.getDeviceWidth(21),
                decoration: BoxDecoration(
                  color: alabaster,
                  borderRadius:
                      BorderRadius.circular(SizeHelper.moderateScale(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      '${item['icon']}',
                    ),
                    const Gap(gap: 20),
                    Text(
                      '${item['text']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: interBold,
                        color: item['textColor'] as Color,
                        fontSize: SizeHelper.moderateScale(10),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const Gap(gap: 15),
          SizedBox(
            height: SizeHelper.moderateScale(250),
            width: SizeHelper.screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                SizeHelper.moderateScale(16),
              ),
              child: GoogleMap(
                circles: circles,
                initialCameraPosition: cameraPosition,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
          ),
          const Gap(gap: 25),
        ],
      ),
    );
  }
}
