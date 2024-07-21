import 'package:flutter/material.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/car/car_categories.dart';
import 'package:toyota/pages/car/new_cars.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ServiceItem(
              bgImagePath: "assets/images/img_services.png",
              title: "Үйлчилгээний цаг авах",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CarSelectPage.routeName,
                  arguments: "booking",
                );
              },
            ),
            VSpacer(),
            ServiceItemWhite(
              bgImagePath: "assets/images/logo.png",
              title: "Шинэ автомашин",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NewCars.routeName,
                );
              },
            ),
            VSpacer(),
            ServiceItemWhite(
              bgImagePath: "assets/images/img_toyotaQ.png",
              title: "Жагсаалт харах",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NewCars.routeName,
                  arguments: "toyotaQ",
                );
              },
            ),
            VSpacer(),
            ServiceItem(
              bgImagePath: "assets/images/img_tire.png",
              title: "Дугуй болон сэлбэг",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CarCategories.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItemWhite extends StatelessWidget {
  const ServiceItemWhite({
    super.key,
    required this.bgImagePath,
    required this.title,
    required this.onPressed,
  });
  final String bgImagePath;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      child: Container(
        height: 173,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(bgImagePath),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GeneralTextStyles.titleText(
                      context,
                      textColor: GeneralColors.blackColor,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: GeneralColors.primaryColor, borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: GeneralColors.whiteColor,
                    size: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.bgImagePath,
    required this.title,
    required this.onPressed,
  });

  final String bgImagePath;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return CustomButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 153,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              GeneralColors.blackColor.withOpacity(0.5),
              BlendMode.darken,
            ),
            fit: BoxFit.fill,
            image: AssetImage(bgImagePath),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GeneralTextStyles.titleText(
                    context,
                    textColor: GeneralColors.whiteColor,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: GeneralColors.whiteColor, borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: GeneralColors.primaryColor,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
