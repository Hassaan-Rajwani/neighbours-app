import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class SenderWidget extends StatelessWidget {
  const SenderWidget({
    required this.senderMessage,
    super.key,
  });

  final String senderMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeHelper.moderateScale(22),
        right: SizeHelper.moderateScale(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeHelper.moderateScale(90),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(SizeHelper.moderateScale(14)),
                decoration: BoxDecoration(
                  color: cornflowerBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeHelper.moderateScale(40)),
                    bottomLeft: Radius.circular(SizeHelper.moderateScale(40)),
                    topRight: Radius.circular(SizeHelper.moderateScale(40)),
                  ),
                ),
                child: Text(
                  senderMessage,
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: SizeHelper.moderateScale(12),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecieverWidget extends StatelessWidget {
  const RecieverWidget({
    required this.recieverMessage,
    super.key,
  });

  final String recieverMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeHelper.moderateScale(22),
        left: SizeHelper.moderateScale(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: SizeHelper.moderateScale(90),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(SizeHelper.moderateScale(14)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(SizeHelper.moderateScale(40)),
                    topLeft: Radius.circular(SizeHelper.moderateScale(40)),
                    bottomRight: Radius.circular(SizeHelper.moderateScale(40)),
                  ),
                ),
                child: Text(
                  recieverMessage,
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: SizeHelper.moderateScale(12),
                    color: codGray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
