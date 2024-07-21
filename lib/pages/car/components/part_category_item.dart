import 'package:flutter/material.dart';
import 'package:toyota/connection/model/category_response.dart';
import 'package:toyota/pages/car/car_parts.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/text_styles.dart';

class PartCategoryItem extends StatelessWidget {
  const PartCategoryItem({
    super.key,
    required this.category,
  });

  final CategoryResponseData category;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          CarParts.routeName,
          arguments: category,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              GeneralColors.blackColor.withOpacity(0.4),
              BlendMode.darken,
            ),
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/img_parts.jpg",
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            category.name ?? "",
            style: GeneralTextStyles.titleText(
              context,
              textColor: GeneralColors.whiteColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
