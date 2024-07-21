import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/car/car_dealers.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  static const String routeName = '/cars-page';

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final NumberFormat numberFormat = NumberFormat("#,##0");
  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)?.settings.arguments as CarResponseData?;
    return Scaffold(
      backgroundColor: GeneralColors.primaryBGColor,
      appBar: CustomAppbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CarDealers.routeName);
        },
        child: Container(
          decoration: BoxDecoration(color: GeneralColors.primaryColor, borderRadius: BorderRadius.circular(50), border: Border.all(color: GeneralColors.whiteColor), boxShadow: [
            BoxShadow(
              color: GeneralColors.blackColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
          child: Text(
            "Холбоо барих",
            style: GeneralTextStyles.titleText(
              context,
              textColor: GeneralColors.whiteColor,
            ),
          ),
        ),
      ),
      body: GeneralContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              car?.name?.trim().isNotEmpty == true
                  ? Text(
                      car?.name ?? "",
                      style: GeneralTextStyles.titleText(
                        context,
                        fontSize: 24,
                      ),
                    )
                  : SizedBox(),
              VSpacer(),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: GeneralColors.grayColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  constraints: BoxConstraints(maxHeight: 250),
                  child: car?.imageWidget ??
                      Image.asset(
                        "assets/icons/ic_car.png",
                      ),
                ),
              ),
              VSpacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: GeneralColors.primaryColor),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: GeneralColors.blackColor.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(5, 10),
                    )
                  ],
                  color: GeneralColors.primaryBGColor,
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car?.modelName ?? "",
                      style: GeneralTextStyles.titleText(context, fontSize: 16),
                    ),
                    Text(
                      "${numberFormat.format(double.tryParse(car?.salePrice ?? "0") ?? 0)}₮",
                      style: GeneralTextStyles.titleText(
                        context,
                        fontSize: 34,
                      ),
                    ),
                    infoWidget(
                      car?.yearString,
                      (value) => Text("Он: $value он"),
                    ),
                    infoWidget(
                      car?.odoMeter,
                      (value) => Text("Гүйлт: $value км"),
                    ),
                    infoWidget(
                      car?.manufacturedYear,
                      (value) => Text("Үйлдвэрлэсэн он: $value"),
                    ),
                    infoWidget(
                      car?.colorName,
                      (value) => Text("Өнгө: $value"),
                    ),
                    infoWidget(
                      car?.engineCapacity,
                      (value) => Text("Моторын багтаамж: $value"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoWidget(String? title, Widget Function(String value) builder) {
    return title?.trim().isNotEmpty == true ? builder(title ?? "") : SizedBox();
  }
}
