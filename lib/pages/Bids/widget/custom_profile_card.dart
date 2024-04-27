// ignore_for_file: unused_field, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/models/bids.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/enum_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/gap.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    required this.onReject,
    required this.onAccept,
    required this.data,
    super.key,
  });

  final VoidCallback onReject;
  final VoidCallback onAccept;
  final BidsModel data;
  @override
  Widget build(BuildContext context) {
    final bytes =
        data.helperInfo.imageUrl != null && data.helperInfo.imageUrl!.isNotEmpty
            ? base64Decode(data.helperInfo.imageUrl.toString())
            : null;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        bytes != null ? Colors.transparent : codGray,
                    backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                    radius: SizeHelper.moderateScale(25),
                    child: bytes == null
                        ? Text(
                            getInitials(
                              firstName: data.helperInfo.firstName,
                              lastName: data.helperInfo.lastName,
                            ),
                            style: TextStyle(
                              fontFamily: ralewayBold,
                              fontSize: SizeHelper.moderateScale(20),
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const Gap(
                    gap: 16,
                    axis: 'x',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '''${data.helperInfo.firstName} ${data.helperInfo.lastName}''',
                        style: TextStyle(
                          fontFamily: ralewayExtrabold,
                          fontSize: SizeHelper.moderateScale(14),
                          color: codGray,
                        ),
                      ),
                      const Gap(gap: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeHelper.moderateScale(2),
                          horizontal: SizeHelper.moderateScale(4),
                        ),
                        decoration: const BoxDecoration(
                          color: cornflowerBlue,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.helperInfo.helperRating.rating
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                fontFamily: urbanistSemiBold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const Gap(
                              gap: 1,
                            ),
                            Icon(
                              Icons.star_rate_rounded,
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
              if (data.status != jobStatus.CANCELLED.name)
                InkWell(
                  child: SvgPicture.asset(chatIcon),
                  onTap: () {
                    final query = Uri(
                      queryParameters: {
                        'name':
                            '''${data.helperInfo.firstName} ${data.helperInfo.lastName}''',
                        'firstName': data.helperInfo.firstName,
                        'lastName': data.helperInfo.lastName,
                        'userId': data.neighbourId,
                        'helperId': data.helperInfo.id,
                        'image': data.helperInfo.imageUrl.toString(),
                      },
                    ).query;
                    context.push(
                      '${ChatPage.routeName}?$query',
                    );
                  },
                ),
            ],
          ),
          const Gap(gap: 16),
          if (data.description != '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: interRegular,
                      fontSize: SizeHelper.moderateScale(12),
                    ),
                    children: [
                      const TextSpan(
                        text: 'Description\n',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text: '\n',
                        style: TextStyle(
                          height: 0.8,
                        ),
                      ),
                      TextSpan(
                        text: data.description,
                        style: const TextStyle(
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(gap: 16),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: SizeHelper.moderateScale(12),
                      fontFamily: interRegular,
                    ),
                  ),
                  const Gap(gap: 6),
                  Text(
                    '\$ ${data.amount}',
                    style: TextStyle(
                      color: chateauGreen,
                      fontSize: SizeHelper.moderateScale(24),
                      fontFamily: ralewayExtrabold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distance',
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: SizeHelper.moderateScale(12),
                      fontFamily: interRegular,
                    ),
                  ),
                  const Gap(gap: 10),
                  Text(
                    '''${data.distance.toStringAsFixed(1)} ${data.distanceUnit}''',
                    style: TextStyle(
                      color: mineShaft,
                      fontSize: SizeHelper.moderateScale(14),
                      fontFamily: interBold,
                    ),
                  ),
                  const Gap(gap: 6),
                ],
              ),
              if (data.status == jobStatus.CANCELLED.name ||
                  data.status == jobStatus.APPROVED.name)
                Text(
                  data.status == jobStatus.CANCELLED.name
                      ? 'Rejected'
                      : jobStatus.APPROVED.name,
                  style: TextStyle(
                    color: data.status == jobStatus.CANCELLED.name
                        ? Colors.red
                        : chateauGreen,
                    fontSize: SizeHelper.moderateScale(14),
                    fontFamily: urbanistBold,
                  ),
                )
              else
                Row(
                  children: [
                    InkWell(
                      onTap: onReject,
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeHelper.moderateScale(90),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeHelper.moderateScale(11),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: SizeHelper.moderateScale(14),
                            fontFamily: urbanistBold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(
                      gap: 10,
                      axis: 'x',
                    ),
                    InkWell(
                      onTap: onAccept,
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeHelper.moderateScale(90),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeHelper.moderateScale(11),
                        ),
                        child: Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeHelper.moderateScale(14),
                            fontFamily: urbanistBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
