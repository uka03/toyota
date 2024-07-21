import 'package:flutter/material.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/pages/detail/detail_page.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/text_styles.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    required this.banner,
  });
  final DefaultResponseData? banner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: banner);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: banner?.imageWidget,
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner?.name ?? "",
                            style: GeneralTextStyles.titleText(
                              context,
                              fontSize: 24,
                              textColor: GeneralColors.whiteColor,
                            ),
                          ),
                          Text(
                            banner?.description ?? "",
                            style: GeneralTextStyles.bodyText(
                              context,
                              fontSize: 14,
                              textColor: GeneralColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: GeneralColors.whiteColor,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: GeneralColors.whiteColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
