import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/pages/home/components/banner_item.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({
    super.key,
    required this.banners,
    this.onPageChanged,
    required this.bannerIndex,
  });
  final List<DefaultResponseData?> banners;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final int bannerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((banner) {
            return BannerItem(
              banner: banner,
            );
          }).toList(),
          options: CarouselOptions(
            viewportFraction: 0.93,
            enlargeCenterPage: false,
            initialPage: 0,
            height: 250,
            enableInfiniteScroll: true,
            autoPlay: false,
            disableCenter: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: onPageChanged,
          ),
        ),
        VSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              width: bannerIndex == index ? 20 : 12,
              height: 8,
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: bannerIndex == index ? GeneralColors.primaryColor : GeneralColors.whiteColor,
                border: Border.all(color: bannerIndex == index ? GeneralColors.primaryColor : GeneralColors.blackColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
