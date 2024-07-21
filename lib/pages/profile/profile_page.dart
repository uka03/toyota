import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/booking/booking_order_page.dart';
import 'package:toyota/pages/booking/booking_page.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/booking/history_page.dart';
import 'package:toyota/pages/home/home_page.dart';
import 'package:toyota/pages/profile/profile_edit.dart';
import 'package:toyota/pages/profile/provider/profile_provider.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/constants.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider _profileProvider;
  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      await _profileProvider.getCars();
      await _profileProvider.getMe();
      await _profileProvider.getNews();
      dismissLoader();
    });
  }

  onPressed(ServiceItemData service, CarResponseData car) {
    switch (service.index) {
      case 1:
        Navigator.pushNamed(
          context,
          BookingPage.routeName,
          arguments: car,
        );
        break;
      case 2:
        Navigator.pushNamed(
          context,
          BookingOrderPage.routeName,
          arguments: car,
        );
        break;
      case 3:
        Navigator.pushNamed(
          context,
          HistoryPage.routeName,
          arguments: car,
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: GeneralColors.primaryBGColor,
        body: GeneralContainer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GeneralColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        "assets/icons/ic_user.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    HSpacer(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.user?.firstName ?? "",
                            style: GeneralTextStyles.titleText(
                              context,
                              fontSize: 18,
                            ),
                          ),
                          provider.user?.lastName?.isNotEmpty == true
                              ? Text(
                                  provider.user?.lastName ?? "",
                                  style: GeneralTextStyles.bodyText(
                                    context,
                                    fontSize: 16,
                                    textColor: GeneralColors.grayTextColor,
                                  ),
                                )
                              : Text(
                                  provider.user?.vat ?? "",
                                  style: GeneralTextStyles.titleText(context),
                                )
                        ],
                      ),
                    ),
                    HSpacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ProfileEdit.routeName,
                        );
                      },
                      icon: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.edit,
                        ),
                      ),
                    )
                  ],
                ),
                VSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Бүртгэлтэй машин",
                      style: GeneralTextStyles.titleText(context, fontSize: 20),
                    ),
                    provider.cars.length > 4
                        ? CustomButton(
                            onPressed: () {},
                            child: Text(
                              "Бүгд",
                              style: GeneralTextStyles.bodyText(
                                context,
                                textColor: GeneralColors.primaryColor,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                VSpacer(),
                GridView.builder(
                  itemCount: provider.cars.length > 4 ? 4 : provider.cars.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final car = provider.cars[index];
                    return CarItem(
                      car: car,
                      onTap: (car) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              backgroundColor: GeneralColors.primaryBGColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              title: Text("Үйлчилгээ сонгоно уу?"),
                              titleTextStyle: GeneralTextStyles.titleText(context),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: services
                                    .map(
                                      (e) => CustomButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          onPressed(e, car);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.symmetric(vertical: 6),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                e.icon,
                                                width: 25,
                                                height: 25,
                                              ),
                                              HSpacer.sm(),
                                              Expanded(child: Text(e.title)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                VSpacer(),
                Text(
                  'Мэдээ Мэдээлэл',
                  style: GeneralTextStyles.titleText(context, fontSize: 20),
                ),
                VSpacer(),
                SizedBox(
                  height: 170,
                  child: ListView.separated(
                    itemCount: provider.news.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => HSpacer(),
                    itemBuilder: (context, index) {
                      final news = provider.news[index];
                      return NewsItem(news: news);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
