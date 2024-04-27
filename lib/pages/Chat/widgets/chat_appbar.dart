import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.image,
    this.onTap,
    super.key,
  });

  final String name;
  final String firstName;
  final String lastName;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bytes = image != '' && image != 'null' ? base64Decode(image) : null;
    return Container(
      padding: EdgeInsets.all(
        SizeHelper.moderateScale(
          20,
        ),
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap ??
                () {
                  context.pop();
                },
            child: CircleAvatar(
              backgroundColor: cornflowerBlue,
              minRadius: SizeHelper.moderateScale(20),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                name.pascalCase,
                style: TextStyle(
                  fontFamily: ralewayBold,
                  fontSize: SizeHelper.moderateScale(16),
                  color: codGray,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: bytes != null ? Colors.transparent : codGray,
            backgroundImage: bytes != null ? MemoryImage(bytes) : null,
            radius: SizeHelper.moderateScale(22),
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
        ],
      ),
    );
  }
}
