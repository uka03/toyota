import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/category_response.dart';
import 'package:toyota/pages/car/car_parts.dart';
import 'package:toyota/pages/car/components/part_category_item.dart';
import 'package:toyota/pages/car/provider/car_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class CarCategories extends StatefulWidget {
  const CarCategories({super.key});

  static const String routeName = '/part-categories';

  @override
  State<CarCategories> createState() => _CarCategoriesState();
}

class _CarCategoriesState extends State<CarCategories> {
  late final CarProvider carProvider;
  @override
  void initState() {
    super.initState();
    carProvider = Provider.of<CarProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      await carProvider.getCategories();
      dismissLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CarProvider, List<CategoryResponseData>>(
        selector: (p0, p1) => p1.categories,
        builder: (context, categories, child) {
          return Scaffold(
            backgroundColor: GeneralColors.primaryBGColor,
            appBar: CustomAppbar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CarParts.routeName,
                          arguments: CategoryResponseData(
                            id: -2,
                            name: "Bridgestone",
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 153,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/img_tire.png",
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bridgestone",
                              style: GeneralTextStyles.titleText(
                                context,
                                textColor: GeneralColors.whiteColor,
                                fontSize: 26,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(color: GeneralColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Дугуй үзэх",
                                style: GeneralTextStyles.titleText(
                                  context,
                                  textColor: GeneralColors.whiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: GeneralColors.grayBGColor,
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Сэлбэгийн ангилал",
                        style: GeneralTextStyles.titleText(
                          context,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: categories.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return PartCategoryItem(category: category);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
