import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.imagePath,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.onRemovePressed,
    super.key,
  });

  final String imagePath;
  final String name;
  final String firstName;
  final String lastName;
  final double rating;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final bytes =
        imagePath != '' && imagePath != 'null' ? base64Decode(imagePath) : null;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
        vertical: SizeHelper.moderateScale(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: bytes != null ? Colors.transparent : codGray,
                backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                radius: SizeHelper.moderateScale(20),
                child: bytes == null
                    ? Text(
                        getInitials(
                          firstName: firstName,
                          lastName: lastName,
                        ),
                        style: TextStyle(
                          fontFamily: ralewayBold,
                          fontSize: SizeHelper.moderateScale(16),
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const Gap(
                gap: 15,
                axis: 'x',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: SizeHelper.moderateScale(14),
                      fontFamily: ralewayBold,
                    ),
                  ),
                  const Gap(
                    gap: 6,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(5),
                      vertical: SizeHelper.moderateScale(2),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: SizeHelper.moderateScale(12),
                            fontFamily: urbanistSemiBold,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(
                          gap: 2,
                          axis: 'x',
                        ),
                        Icon(
                          Icons.star,
                          size: SizeHelper.moderateScale(12),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onRemovePressed,
            child: Container(
              padding: EdgeInsets.all(
                SizeHelper.moderateScale(10),
              ),
              child: Text(
                'Remove',
                style: TextStyle(
                  fontFamily: ralewaySemibold,
                  fontSize: SizeHelper.moderateScale(14),
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
