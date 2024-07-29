import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isLogout = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: isLogout ? GeneralColors.primaryColor : GeneralColors.grayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: isLogout ? GeneralColors.primaryColor : GeneralColors.grayTextColor,
            ),
            HSpacer(),
            Expanded(
              child: Text(
                title,
                style: GeneralTextStyles.titleText(
                  context,
                  textColor: isLogout ? GeneralColors.primaryColor : GeneralColors.blackColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
