import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    required this.firstName,
    required this.lastName,
    super.key,
  });

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          final bytes =
              state.imageUrl != null ? base64Decode(state.imageUrl!) : null;
          return CircleAvatar(
            backgroundColor: bytes != null ? Colors.transparent : codGray,
            backgroundImage: bytes != null ? MemoryImage(bytes) : null,
            radius: SizeHelper.moderateScale(25),
            child: bytes == null
                ? Text(
                    getInitials(
                      firstName: firstName,
                      lastName: lastName,
                    ),
                    style: TextStyle(
                      fontFamily: ralewayBold,
                      fontSize: SizeHelper.moderateScale(20),
                      color: Colors.white,
                    ),
                  )
                : null,
          );
        }
        return Container();
      },
    );
  }
}
