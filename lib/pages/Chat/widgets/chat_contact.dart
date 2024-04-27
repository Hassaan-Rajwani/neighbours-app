// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';

class ChatContact extends StatefulWidget {
  const ChatContact({
    required this.name,
    required this.image,
    required this.message,
    required this.unreadMessages,
    required this.time,
    required this.onTap,
    super.key,
    this.isTyping,
  });
  final String name;
  final String image;
  final String message;
  final bool? isTyping;
  final String unreadMessages;
  final String time;
  final VoidCallback onTap;

  @override
  State<ChatContact> createState() => _ChatContactState();
}

class _ChatContactState extends State<ChatContact> {
  @override
  Widget build(BuildContext context) {
    final bytes = widget.image != null ? base64Decode(widget.image) : null;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeHelper.moderateScale(10)),
      child: ListTile(
        onTap: widget.onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeHelper.moderateScale(
              8,
            ),
          ),
        ),
        minVerticalPadding: SizeHelper.moderateScale(5),
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeHelper.moderateScale(
            10,
          ),
          vertical: SizeHelper.moderateScale(
            5,
          ),
        ),
        leading: CircleAvatar(
          backgroundColor:
              widget.image != 'null' ? Colors.transparent : codGray,
          backgroundImage: widget.image != 'null' ? MemoryImage(bytes!) : null,
          radius: SizeHelper.moderateScale(25),
          child: widget.image == 'null'
              ? Text(
                  getInitials(
                    firstName: widget.name,
                    lastName: widget.name.characters.last,
                  ),
                  style: TextStyle(
                    fontFamily: ralewayBold,
                    fontSize: SizeHelper.moderateScale(20),
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        title: Text(
          widget.name.pascalCase,
          style: TextStyle(
            fontFamily: ralewayBold,
            fontSize: SizeHelper.moderateScale(16),
            color: codGray,
          ),
        ),
        subtitle: Text(
          widget.message,
          style: TextStyle(
            fontFamily: interMedium,
            fontSize: SizeHelper.moderateScale(12),
            color: widget.unreadMessages == '0' ? doveGray : mineShaft,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.time,
              style: TextStyle(
                fontFamily: interBold,
                fontSize: SizeHelper.moderateScale(12),
                color: silverColor,
              ),
            ),
            if (widget.unreadMessages != '0')
              CircleAvatar(
                radius: SizeHelper.moderateScale(8),
                backgroundColor: cornflowerBlue,
                child: Text(
                  widget.unreadMessages,
                  style: TextStyle(
                    fontFamily: interBold,
                    fontSize: SizeHelper.moderateScale(8),
                    color: Colors.white,
                  ),
                ),
              )
            else
              const Text(''),
          ],
        ),
      ),
    );
  }
}
