// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';

class ChatInput extends StatefulWidget {
  ChatInput({
    required this.onPress,
    required this.msg,
    required this.isMessageEmpty,
    super.key,
  });

  final VoidCallback onPress;
  final TextEditingController msg;
  bool isMessageEmpty;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        SizeHelper.moderateScale(20),
        SizeHelper.moderateScale(0),
        SizeHelper.moderateScale(20),
        SizeHelper.moderateScale(20),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (text) {
          setState(() {
            widget.isMessageEmpty = text.trim().isEmpty;
          });
        },
        controller: widget.msg,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(20),
            vertical: SizeHelper.moderateScale(20),
          ),
          hintText: 'Type...',
          hintStyle: TextStyle(
            fontFamily: interMedium,
            fontSize: SizeHelper.moderateScale(12),
            color: dustyGray,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: InkWell(
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeHelper.moderateScale(
                  100,
                ),
              ),
            ),
            onTap: widget.isMessageEmpty ? null : widget.onPress,
            child: Padding(
              padding: EdgeInsets.all(
                SizeHelper.moderateScale(5),
              ),
              child: SvgPicture.asset(
                sendMessageIcon,
                height: SizeHelper.moderateScale(60),
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizeHelper.moderateScale(70),
            ),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizeHelper.moderateScale(70),
            ),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              SizeHelper.moderateScale(70),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        minLines: 1,
        maxLines: 5,
      ),
    );
  }
}
