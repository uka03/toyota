import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class PlateNumber extends StatelessWidget {
  const PlateNumber({
    super.key,
    required this.plateNumber,
  });

  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    String platStrings = "";
    String plateNumbers = "";
    plateNumber.split("").forEach((value) {
      if (int.tryParse(value) != null) {
        plateNumbers += value;
      } else {
        platStrings += value;
      }
    });
    return Container(
      decoration: BoxDecoration(color: GeneralColors.whiteColor, border: Border.all(), borderRadius: BorderRadius.circular(4), boxShadow: [
        BoxShadow(
          color: GeneralColors.blackColor.withOpacity(0.7),
          blurRadius: 10,
          spreadRadius: -3,
          offset: Offset(0, 3),
        )
      ]),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/ic_soyombo.png",
            height: 10,
            color: GeneralColors.primaryColor,
          ),
          HSpacer(size: 2),
          Text(plateNumbers),
          HSpacer(size: 2),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.all(1),
            child: Text(
              "MGL",
              style: GeneralTextStyles.bodyText(
                context,
                fontSize: 4,
              ),
            ),
          ),
          HSpacer(size: 2),
          Text(platStrings.trim()),
        ],
      ),
    );
  }
}
