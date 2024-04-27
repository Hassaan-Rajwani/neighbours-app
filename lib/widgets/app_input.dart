import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/gap.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    required this.placeHolder,
    this.error = '',
    this.label = '',
    this.keyboardType,
    this.controller,
    this.showPasswordIcon = false,
    this.onTap,
    this.obscureText = false,
    this.isAutoValidate = false,
    this.validator,
    this.enabled,
    this.horizontalMargin = 20,
    this.bottomMargin = 20,
    this.maxLines = 1,
    this.maxLenght = 100,
    this.prefixIcon,
    this.postfixIcon,
    this.onChanged,
    this.onEnventSumbit,
    this.textarea = true,
    this.backColor = athensGray,
    this.isCounterText = false,
    this.isAutoFocus = false,
    super.key,
  });

  final String placeHolder;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? showPasswordIcon;
  final VoidCallback? onTap;
  final bool? obscureText;
  final bool isAutoValidate;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onEnventSumbit;
  final bool? enabled;
  final int? horizontalMargin;
  final int? bottomMargin;
  final int? maxLines;
  final int? maxLenght;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final String error;
  final bool textarea;
  final Color? backColor;
  final bool isCounterText;
  final bool isAutoFocus;

  @override
  Widget build(BuildContext context) {
    final customInputDecoration = InputDecoration(
      prefixIcon: prefixIcon,
      counterText: isCounterText ? null : '',
      filled: true,
      fillColor: backColor,
      hintText: placeHolder,
      iconColor: const Color(0xFFD4DDE5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: athensGray),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: athensGray,
        ),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(
          SizeHelper.moderateScale(8),
        ),
      ),
      hintStyle: textarea
          ? TextStyle(
              color: const Color(0xFF8D99AE),
              fontSize: SizeHelper.moderateScale(14),
              fontFamily: 'Raleway',
            )
          : TextStyle(
              color: silver,
              fontSize: SizeHelper.moderateScale(10),
              fontFamily: 'Nunito',
            ),
      suffixIcon: showPasswordIcon!
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeHelper.moderateScale(5),
                  SizeHelper.moderateScale(5),
                  SizeHelper.moderateScale(20),
                  SizeHelper.moderateScale(5),
                ),
                child: obscureText!
                    ? const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xFFCACACA),
                      )
                    : const Icon(
                        FontAwesomeIcons.eyeSlash,
                        size: 18,
                        color: Color(0xFFCACACA),
                      ),
              ),
            )
          : postfixIcon,
      errorText: error.isEmpty ? null : error,
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: SizeHelper.moderateScale(12),
        fontFamily: interRegular,
      ),
      counterStyle: TextStyle(
        fontSize: SizeHelper.moderateScale(12),
        fontFamily: interRegular,
        color: codGray,
      ),
    );

    return Container(
      margin: EdgeInsets.fromLTRB(
        SizeHelper.moderateScale(horizontalMargin!),
        0,
        SizeHelper.moderateScale(horizontalMargin!),
        SizeHelper.moderateScale(bottomMargin!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label! == '')
            Container()
          else
            Container(
              margin: EdgeInsets.only(left: SizeHelper.moderateScale(0)),
              child: Text(
                label!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeHelper.moderateScale(14),
                  fontFamily: ralewaySemibold,
                ),
              ),
            ),
          const Gap(gap: 8),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            child: TextFormField(
              onFieldSubmitted: onEnventSumbit,
              autofocus: isAutoFocus,
              style: TextStyle(
                color: const Color(0xFF214465),
                fontSize: SizeHelper.moderateScale(14),
                fontFamily: interSemibold,
              ),
              keyboardType: keyboardType,
              controller: controller,
              onChanged: onChanged,
              decoration: customInputDecoration,
              obscureText: obscureText!,
              validator: validator,
              // autovalidateMode: isAutoValidate!
              //     ? AutovalidateMode.onUserInteraction
              //     : AutovalidateMode.disabled,

              enabled: enabled,
              maxLines: maxLines,
              maxLength: maxLenght,
            ),
          ),
        ],
      ),
    );
  }
}
