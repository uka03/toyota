import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toyota/utils/colors.dart';

class CustomPincode extends StatelessWidget {
  const CustomPincode({
    super.key,
    required this.controller,
    required this.onFinished,
  });

  final TextEditingController controller;
  final Function(String value) onFinished;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      enableActiveFill: true,
      mainAxisAlignment: MainAxisAlignment.center,
      appContext: context,
      autoFocus: true,
      obscureText: true,
      obscuringCharacter: "*",
      pastedTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: GeneralColors.whiteColor,
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: GeneralColors.whiteColor,
      ),
      length: 4,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60,
        fieldWidth: 60,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5),
        selectedColor: GeneralColors.primaryColor,
        selectedFillColor: GeneralColors.primaryColor,
        inactiveFillColor: GeneralColors.grayBGColor,
        inactiveColor: GeneralColors.grayBGColor,
        activeColor: GeneralColors.primaryColor,
        activeFillColor: GeneralColors.primaryColor,
      ),
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      keyboardType: TextInputType.number,
      onSubmitted: (val) {},
      onCompleted: onFinished,
    );
  }
}
