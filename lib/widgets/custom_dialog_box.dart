import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/gap.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    required this.onConfirmPressed,
    required this.onCancelPressed,
    required this.confirmText,
    required this.cancelText,
    required this.confirmTextColor,
    required this.cancelTextColor,
    required this.confirmBtnBackgroundColor,
    required this.cancelBtnBackgroundColor,
    required this.heading,
    required this.description,
    required this.verticalHeight,
    this.inputArea = false,
    this.isHelpText = false,
    this.controller,
    this.description2 = '',
    this.description3 = '',
    super.key,
  });
  final void Function() onConfirmPressed;
  final void Function() onCancelPressed;
  final String confirmText;
  final String cancelText;
  final Color confirmTextColor;
  final Color cancelTextColor;
  final Color confirmBtnBackgroundColor;
  final Color cancelBtnBackgroundColor;
  final String heading;
  final String description;
  final String description2;
  final String description3;
  final int verticalHeight;
  final bool inputArea;
  final bool isHelpText;
  final TextEditingController? controller;

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final _formKey = GlobalKey<FormState>();
  int reasonCharacterCount = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: SizeHelper.moderateScale(0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            padding:
                EdgeInsets.symmetric(horizontal: SizeHelper.moderateScale(17)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeHelper.moderateScale(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(gap: 20),
                Text(
                  widget.heading,
                  style: TextStyle(
                    fontSize: SizeHelper.moderateScale(16),
                    fontFamily: urbanistBold,
                  ),
                ),
                const Gap(gap: 15),
                if (widget.description == '')
                  SizedBox(
                    width: SizeHelper.screenWidth,
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(15),
                    ),
                    width: SizeHelper.screenWidth,
                    child: !widget.isHelpText
                        ? Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(12),
                              fontFamily: urbanistMedium,
                              color: darkGray,
                              height: 1.4,
                            ),
                          )
                        : Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              style: TextStyle(
                                fontSize: SizeHelper.moderateScale(12),
                                fontFamily: urbanistMedium,
                                color: darkGray,
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(text: widget.description),
                                TextSpan(
                                  text: '(1) Open Dispute',
                                  style: TextStyle(
                                    fontSize: SizeHelper.moderateScale(12),
                                    fontFamily: urbanistBold,
                                    color: codGray,
                                    height: 1.4,
                                  ),
                                ),
                                TextSpan(text: widget.description2),
                                TextSpan(
                                  text: '(2) Cancel Job',
                                  style: TextStyle(
                                    fontSize: SizeHelper.moderateScale(12),
                                    fontFamily: urbanistBold,
                                    color: codGray,
                                    height: 1.4,
                                  ),
                                ),
                                TextSpan(text: widget.description3),
                              ],
                            ),
                          ),
                  ),
                Gap(gap: widget.description == '' ? 30 : 20),
                if (widget.inputArea)
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Write Reason',
                          style: TextStyle(
                            fontFamily: ralewayBold,
                            fontSize: SizeHelper.moderateScale(10),
                          ),
                        ),
                      ),
                      const Gap(gap: 5),
                      AppInput(
                        horizontalMargin: 0,
                        textarea: false,
                        placeHolder: 'Description here',
                        maxLines: 5,
                        controller: widget.controller,
                        validator: ProjectRegex.descriptionValidator,
                        onChanged: (text) {
                          final currentCount = text.length;
                          setState(() {
                            reasonCharacterCount = currentCount;
                          });
                        },
                        maxLenght: 200,
                      ),
                      Container(
                        width: SizeHelper.getDeviceWidth(100),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$reasonCharacterCount/200',
                          style: TextStyle(
                            fontFamily: interBold,
                            fontSize: SizeHelper.moderateScale(10),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(gap: 20),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onCancelPressed();
                      },
                      child: Container(
                        width: SizeHelper.moderateScale(144),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeHelper.moderateScale(13),
                          horizontal: SizeHelper.moderateScale(15),
                        ),
                        decoration: BoxDecoration(
                          color: widget.cancelBtnBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.cancelText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.cancelTextColor,
                            fontSize: SizeHelper.moderateScale(14),
                            fontFamily: urbanistBold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.inputArea) {
                          if (_formKey.currentState!.validate()) {
                            widget.onConfirmPressed();
                          }
                        } else {
                          widget.onConfirmPressed();
                        }
                      },
                      child: Container(
                        width: SizeHelper.moderateScale(144),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeHelper.moderateScale(13),
                          horizontal: SizeHelper.moderateScale(15),
                        ),
                        decoration: BoxDecoration(
                          color: widget.confirmBtnBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.confirmText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.confirmTextColor,
                            fontFamily: urbanistBold,
                            fontSize: SizeHelper.moderateScale(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(gap: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
