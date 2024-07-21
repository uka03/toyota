import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? GeneralColors.primaryColor : GeneralColors.blackColor,
        ),
        borderRadius: BorderRadius.circular(4),
        color: value ? GeneralColors.primaryColor : GeneralColors.whiteColor,
      ),
      child: Icon(
        Icons.check_rounded,
        size: 16,
        color: value ? GeneralColors.whiteColor : GeneralColors.blackColor,
      ),
    );
  }
}
