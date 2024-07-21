import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.backgroundColor,
    this.width,
    this.height,
    this.icon,
    this.suffixIcon,
    this.borderRadius,
    this.borderColor,
  });

  final VoidCallback onPressed;
  final Widget text;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final IconData? suffixIcon;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      onTap: onPressed,
      child: Container(
        height: height ?? 37,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isDisabled ? GeneralColors.grayColor : backgroundColor ?? Colors.transparent,
          border: Border.all(
            color: isDisabled ? GeneralColors.grayColor : borderColor ?? GeneralColors.grayColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
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
