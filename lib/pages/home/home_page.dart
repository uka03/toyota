import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/detail/detail_page.dart';
import 'package:toyota/pages/home/components/banner_carousel.dart';
import 'package:toyota/pages/home/provider/home_provider.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/constants.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeProvider _homeProvider;

  int bannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeProvider.getHomeData();
    });
  }

  onPressed(ServiceItemData service) {
    switch (service.index) {
      case 1:
        Navigator.pushNamed(context, CarSelectPage.routeName, arguments: "booking");
        break;
      case 2:
        Navigator.pushNamed(context, CarSelectPage.routeName, arguments: "booking-order");
        break;
      case 3:
        Navigator.pushNamed(context, CarSelectPage.routeName, arguments: "history");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpacer(),
              BannerCarousel(
                banners: provider.banners,
                onPageChanged: (index, _) {
                  setState(() {
                    bannerIndex = index;
                  });
                },
                bannerIndex: bannerIndex,
              ),
              VSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Үйлчилгээ',
                  style: GeneralTextStyles.titleText(context, fontSize: 20),
                ),
              ),
              VSpacer(),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (BuildContext context, int index) => HSpacer(),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return ServiceItem(
                      service: service,
                      onPressed: onPressed,
                    );
                  },
                ),
              ),
              VSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Мэдээ Мэдээлэл',
                  style: GeneralTextStyles.titleText(context, fontSize: 20),
                ),
              ),
              VSpacer(),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  itemCount: provider.news.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (context, index) => HSpacer(),
                  itemBuilder: (context, index) {
                    final news = provider.news[index];
                    return NewsItem(news: news);
                  },
                ),
              ),
              VSpacer.lg(),
            ],
          ),
        );
      },
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.news,
  });

  final DefaultResponseData? news;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: news);
      },
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 170,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: news?.imageWidget ?? SizedBox(),
            ),
          ),
          Positioned.fill(
            child: Container(
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
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news?.name ?? '',
                    style: GeneralTextStyles.titleText(
                      context,
                      fontSize: 14,
                      textColor: GeneralColors.whiteColor,
                    ),
                  ),
                  Text(
                    news?.description ?? '',
                    style: GeneralTextStyles.bodyText(
                      context,
                      fontSize: 12,
                      textColor: GeneralColors.whiteColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.service,
    required this.onPressed,
  });

  final ServiceItemData service;
  final Function(ServiceItemData) onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        onPressed(service);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: service.index == 1 ? GeneralColors.primaryColor : GeneralColors.grayColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              service.icon,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              color: service.index == 1 ? GeneralColors.primaryColor : GeneralColors.grayColor,
            ),
            Text(
              service.title,
              textAlign: TextAlign.center,
              style: GeneralTextStyles.bodyText(
                context,
                textColor: service.index == 1 ? GeneralColors.primaryColor : GeneralColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
