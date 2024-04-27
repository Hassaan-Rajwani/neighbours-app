// ignore_for_file: inference_failure_on_function_return_type
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neighbour_app/data/models/notification_feed_model.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    required this.data,
    this.onDelete,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final Function(BuildContext)? onDelete;
  final NotificationFeedBodyModel data;

  @override
  Widget build(BuildContext context) {
    final bytes = data.sender.imageUrl != '' && data.sender.imageUrl != null
        ? base64Decode(data.sender.imageUrl.toString())
        : null;
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            backgroundColor: const Color(0xFFFBDDDD),
            onPressed: onDelete,
            foregroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: data.isRead ? Colors.white : const Color(0xffE8F6FF),
            border: Border(
              bottom: BorderSide(
                width: SizeHelper.moderateScale(1),
                color: const Color(0xffDADADA),
              ),
            ),
          ),
          padding: EdgeInsets.all(
            SizeHelper.moderateScale(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: SizeHelper.moderateScale(22),
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: bytes != null ? Colors.transparent : codGray,
                  backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                  radius: SizeHelper.moderateScale(45),
                  child: bytes == null
                      ? Text(
                          getInitials(
                            firstName: data.sender.firstName,
                            lastName: data.sender.lastName,
                          ),
                          style: TextStyle(
                            fontFamily: ralewayBold,
                            fontSize: SizeHelper.moderateScale(20),
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
              const Gap(
                gap: 10,
                axis: 'x',
              ),
              SizedBox(
                width: SizeHelper.getDeviceWidth(70),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: interRegular,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: data.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ''' ${data.description}.\n''',
                        style: const TextStyle(
                          fontFamily: interRegular,
                        ),
                      ),
                      TextSpan(
                        text: formatDateTimeToAgo(data.createdAt),
                        style: TextStyle(
                          fontFamily: interRegular,
                          fontSize: SizeHelper.moderateScale(10),
                          color: doveGray,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
