import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toyota/connection/model/part_response.dart';
import 'package:toyota/pages/car/car_dealers.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class PartItem extends StatelessWidget {
  const PartItem({
    super.key,
    required this.part,
  });

  final PartResponseData part;

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat("#,##0");

    return CustomButton(
      onPressed: () {
        Navigator.pushNamed(context, CarDealers.routeName, arguments: "parts");
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: GeneralColors.grayColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                    ),
                    child: part.imageWidget ??
                        Image.asset(
                          "assets/images/img_parts.jpg",
                          fit: BoxFit.fill,
                        ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                part.name ?? " ",
                                maxLines: 2,
                              ),
                              VSpacer.xs(),
                              Text(
                                part.defaultCode ?? "",
                                maxLines: 2,
                                style: GeneralTextStyles.titleText(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: GeneralColors.grayColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: GeneralColors.grayColor),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      child: Text(
                        "₮${numberFormat.format(double.tryParse(part.price ?? "0") ?? 0)}",
                        style: GeneralTextStyles.titleText(
                          context,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
