import 'package:flutter/material.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinCode extends StatelessWidget {
  const AppPinCode({
    required this.otpController,
    super.key,
  });

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      appContext: context,
      enableActiveFill: true,
      enablePinAutofill: false,
      autoDisposeControllers: false,
      keyboardType: TextInputType.number,
      cursorColor: const Color(0xFF63B1FB),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      textStyle: const TextStyle(
        color: Colors.black,
        fontFamily: ralewaySemibold,
      ),
      pinTheme: PinTheme(
        fieldHeight: SizeHelper.moderateScale(50),
        fieldWidth: SizeHelper.moderateScale(50),
        borderWidth: SizeHelper.moderateScale(1),
        borderRadius: BorderRadius.circular(12),
        shape: PinCodeFieldShape.box,
        activeColor: athensGray,
        inactiveColor: athensGray,
        selectedColor: const Color(0xFF63B1FB),
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        selectedBorderWidth: 1,
      ),
      controller: otpController,
      onChanged: (_) {},
    );
  }
}
