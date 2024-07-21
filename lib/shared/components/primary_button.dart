import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.backgroundColor = GeneralColors.primaryColor,
    this.width,
    this.height,
    this.icon,
    this.elevation,
    this.suffixIcon,
    this.borderRadius,
  });

  final VoidCallback onPressed;
  final Widget text;
  final bool isDisabled;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final IconData? suffixIcon;
  final double? elevation, borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if (isDisabled) {
            return;
          }
          onPressed();
        },
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(elevation ?? 0),
          backgroundColor: isDisabled ? WidgetStateProperty.all<Color>(GeneralColors.grayColor) : WidgetStateProperty.all<Color>(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 100),
              side: BorderSide(color: isDisabled ? GeneralColors.grayColor : backgroundColor),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Icon(icon) : SizedBox(),
            Expanded(
              child: Center(child: text),
            ),
            suffixIcon != null ? HSpacer() : SizedBox(),
            suffixIcon != null
                ? Icon(
                    suffixIcon,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
