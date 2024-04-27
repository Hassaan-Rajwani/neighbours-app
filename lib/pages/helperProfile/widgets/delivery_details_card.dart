import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class DeliveryDetailsCard extends StatelessWidget {
  const DeliveryDetailsCard({
    required this.orderId,
    required this.status,
    required this.dateAndTime,
    required this.title,
    required this.amount,
    required this.description,
    super.key,
  });

  final String orderId;
  final String status;
  final String dateAndTime;
  final String title;
  final double amount;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeHelper.moderateScale(20),
      ),
      // color: Colors.amber,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: SizeHelper.moderateScale(10)),
            width: double.maxFinite,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: silverColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${orderId.substring(0, 10)}',
                      style: TextStyle(
                        fontFamily: interBold,
                        fontSize: SizeHelper.moderateScale(
                          16,
                        ),
                        color: codGray,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(
                          14,
                        ),
                        color: status.toLowerCase() == 'ongoing'
                            ? goldenBell
                            : status.toLowerCase() == 'completed'
                                ? chateauGreen
                                : cinnabar,
                      ),
                    ),
                  ],
                ),
                const Gap(gap: 10),
                Text(
                  extractDateAndTime(dateAndTime),
                  style: TextStyle(
                    fontFamily: interMedium,
                    fontSize: SizeHelper.moderateScale(
                      12,
                    ),
                    color: baliHai,
                  ),
                ),
                const Gap(gap: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(
                          14,
                        ),
                        color: codGray,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: r'$ ',
                        style: TextStyle(
                          color: cornflowerBlue,
                          fontSize: SizeHelper.moderateScale(
                            16,
                          ),
                          fontFamily: interMedium,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: amount.toString(),
                            style: TextStyle(
                              color: codGray,
                              fontFamily: interSemibold,
                              fontSize: SizeHelper.moderateScale(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(gap: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: doveGray,
                    fontFamily: interRegular,
                    fontSize: SizeHelper.moderateScale(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
