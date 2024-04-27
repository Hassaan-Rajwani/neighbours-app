// ignore_for_file: file_names, lines_longer_than_80_chars, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/data/models/get_all_helper_model.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class HelpersCard extends StatelessWidget {
  const HelpersCard({
    required this.onTap,
    required this.data,
    super.key,
  });

  final VoidCallback onTap;
  final AllHelpersModel data;

  @override
  Widget build(BuildContext context) {
    final controller = FlipCardController();
    final bytes =
        data.imageUrl != '' && data.imageUrl != 'null' && data.imageUrl != null
            ? base64Decode(
                data.imageUrl.toString(),
              )
            : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(bottom: SizeHelper.moderateScale(20)),
        padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(10),
          vertical: SizeHelper.moderateScale(10),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: silver),
          borderRadius:
              BorderRadius.all(Radius.circular(SizeHelper.moderateScale(8))),
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
                            firstName: data.fisrtName,
                            lastName: data.lastName,
                          ),
                          style: TextStyle(
                            fontFamily: ralewayBold,
                            fontSize: bytes != null
                                ? SizeHelper.moderateScale(20)
                                : SizeHelper.moderateScale(16),
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
                      data.fisrtName,
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
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateUserType) {
                                return Text(
                                  state.userType == homeScreenType.Neighbor.name
                                      ? data.helperInfo.rating
                                          .toStringAsFixed(1)
                                      : data.neighborInfo.rating
                                          .toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: SizeHelper.moderateScale(12),
                                    fontFamily: urbanistSemiBold,
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return Container();
                            },
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
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: SizeHelper.moderateScale(120),
                      child: FlipCard(
                        rotateSide: RotateSide.bottom,
                        onTapFlipping: true,
                        axis: FlipAxis.horizontal,
                        controller: controller,
                        frontWidget: Column(
                          children: [
                            Text(
                              data.milesCategory!.label == null
                                  ? 'DRIVING'
                                  : data.milesCategory!.label ==
                                          'Driving distance'
                                      ? 'DRIVING'
                                      : 'WALKING',
                              style: TextStyle(
                                fontFamily: interBold,
                                fontSize: SizeHelper.moderateScale(14),
                                color: codGray,
                              ),
                            ),
                            const Gap(gap: 10),
                            Text(
                              checkDistanceText(
                                data.milesCategory!.label.toString(),
                              ),
                              style: TextStyle(
                                fontFamily: interBold,
                                fontSize: SizeHelper.moderateScale(12),
                                color: olivine,
                              ),
                            ),
                          ],
                        ),
                        backWidget: Column(
                          children: [
                            Text(
                              'Distance',
                              style: TextStyle(
                                fontFamily: interBold,
                                fontSize: SizeHelper.moderateScale(14),
                                color: codGray,
                              ),
                            ),
                            const Gap(gap: 10),
                            Text(
                              data.milesCategory!.miles.toString(),
                              style: TextStyle(
                                fontFamily: interBold,
                                fontSize: SizeHelper.moderateScale(12),
                                color: olivine,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(
                      gap: 15,
                      axis: 'x',
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        height: SizeHelper.moderateScale(42),
                        width: SizeHelper.moderateScale(42),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cornflowerBlue.withOpacity(0.1),
                        ),
                        child: SvgPicture.asset(
                          messengerIcon,
                          height: SizeHelper.moderateScale(22),
                          width: SizeHelper.moderateScale(22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
