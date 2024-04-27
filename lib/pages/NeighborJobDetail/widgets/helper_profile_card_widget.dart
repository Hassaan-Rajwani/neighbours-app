// ignore_for_file: unused_local_variable, unnecessary_null_comparison, must_be_immutable, lines_longer_than_80_chars, avoid_dynamic_calls, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/widgets/profile_info_widget.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelperProfileCardWidget extends StatefulWidget {
  HelperProfileCardWidget({
    required this.onFavoriteTap,
    required this.isFavorite,
    required this.jobData,
    super.key,
  });
  final VoidCallback onFavoriteTap;
  final dynamic jobData;
  bool isFavorite;

  @override
  State<HelperProfileCardWidget> createState() =>
      _HelperProfileCardWidgetState();
}

class _HelperProfileCardWidgetState extends State<HelperProfileCardWidget> {
  @override
  Widget build(BuildContext context) {
    final bytes = widget.jobData.imageUrl != '' &&
            widget.jobData.imageUrl != 'null' &&
            widget.jobData.imageUrl != null
        ? base64Decode(widget.jobData.imageUrl.toString())
        : null;

    return Container(
      height: SizeHelper.moderateScale(230),
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
                  const Gap(gap: 45),
                  Text(
                    '${widget.jobData.firstName} ${widget.jobData.lastName}',
                    style: TextStyle(
                      fontFamily: ralewayBold,
                      fontSize: SizeHelper.moderateScale(16),
                      color: codGray,
                    ),
                  ),
                  const Gap(gap: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthStateUserType) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileInfoWidget(
                              title: 'Rating',
                              subTitle: state.userType == 'Neighbor'
                                  ? ratingRoundof(
                                      rating: widget.jobData.helper.rating
                                          .toString(),
                                    )
                                  : ratingRoundof(
                                      rating: widget.jobData.neighbr.rating
                                          .toString(),
                                    ),
                              subTitleColor: doveGray,
                              subTitleSize: SizeHelper.moderateScale(12),
                            ),
                            ProfileInfoWidget(
                              title: 'Jobs Done',
                              subTitle: state.userType == 'Neighbor'
                                  ? widget.jobData.helper.jobDone.toString()
                                  : widget.jobData.neighbr.jobDone.toString(),
                              subTitleColor: doveGray,
                              subTitleSize: SizeHelper.moderateScale(12),
                            ),
                            InkWell(
                              onTap: () {
                                widget.onFavoriteTap();
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: SizeHelper.moderateScale(20),
                                  bottom: SizeHelper.moderateScale(8),
                                  top: SizeHelper.moderateScale(10),
                                  left: SizeHelper.moderateScale(20),
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: alto,
                                ),
                                child: SvgPicture.asset(
                                  widget.isFavorite
                                      ? filledHeartIcon
                                      : favouriteIcon,
                                  color: widget.isFavorite
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
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
                          firstName: widget.jobData.firstName.toString(),
                          lastName: widget.jobData.lastName.toString(),
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
