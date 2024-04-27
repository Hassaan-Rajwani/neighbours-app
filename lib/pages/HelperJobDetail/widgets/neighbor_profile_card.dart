import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neighbour_app/data/models/helper_job_model.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NeighborProfileCardWidget extends StatelessWidget {
  const NeighborProfileCardWidget({
    required this.data,
    super.key,
  });

  final HelperJobModel data;

  @override
  Widget build(BuildContext context) {
    final bytes = data.neighbourId.imageUrl != '' &&
            data.neighbourId.imageUrl != 'null' &&
            data.neighbourId.imageUrl != null
        ? base64Decode(data.neighbourId.imageUrl.toString())
        : null;

    return Container(
      height: SizeHelper.moderateScale(150),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: SizeHelper.moderateScale(55),
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeHelper.moderateScale(20),
              ),
              decoration: BoxDecoration(
                color: dinGray,
                borderRadius: BorderRadius.circular(
                  SizeHelper.moderateScale(
                    16,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Gap(gap: 35),
                  Text(
                    '''${data.neighbourId.firstName} ${data.neighbourId.lastName}''',
                    style: TextStyle(
                      fontFamily: ralewayBold,
                      fontSize: SizeHelper.moderateScale(16),
                      color: codGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 5,
            // bottom: 0,
            child: CircleAvatar(
              radius: SizeHelper.moderateScale(50),
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: bytes != null ? Colors.transparent : codGray,
                backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                radius: SizeHelper.moderateScale(45),
                child: bytes == null
                    ? Text(
                        getInitials(
                          firstName: data.neighbourId.firstName,
                          lastName: data.neighbourId.lastName,
                        ),
                        style: TextStyle(
                          fontFamily: ralewayBold,
                          fontSize: SizeHelper.moderateScale(40),
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
