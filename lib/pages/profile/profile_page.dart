import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/auth/login_page.dart';
import 'package:toyota/pages/auth/password_change.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/pages/booking/booking_order_page.dart';
import 'package:toyota/pages/booking/booking_page.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/booking/history_page.dart';
import 'package:toyota/pages/menu/contact.dart';
import 'package:toyota/pages/menu/menu.dart';
import 'package:toyota/pages/menu/qa_page.dart';
import 'package:toyota/pages/profile/profile_edit.dart';
import 'package:toyota/pages/profile/provider/profile_provider.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/components/secondary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/provider/navigator_provider.dart';
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
  late final NavigatorProvider navigatorProvider;
  late final AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    navigatorProvider = Provider.of<NavigatorProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

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

  onLogout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: GeneralColors.primaryBGColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Та гарахдаа итгэлтэй байна уу!",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: GeneralTextStyles.titleText(context, fontSize: 18),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    borderRadius: 4,
                    height: 45,
                    text: Text(
                      "Үгүй",
                      style: GeneralTextStyles.titleText(
                        context,
                        textColor: GeneralColors.blackColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                HSpacer(),
                Expanded(
                  child: PrimaryButton(
                    borderRadius: 4,
                    height: 45,
                    text: Text(
                      "Тийм",
                      style: GeneralTextStyles.titleText(
                        context,
                        textColor: GeneralColors.whiteColor,
                      ),
                    ),
                    onPressed: () async {
                      final response = await authProvider.logout();
                      if (response) {
                        if (mounted) {
                          navigatorProvider.changeIndex(0);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, LoginPage.routeName);
                        }
                      }
                    },
                  ),
                )
              ],
            )
          ],
        );
      },
    );
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Бүртгэлтэй машин",
                      style: GeneralTextStyles.titleText(context, fontSize: 20),
                    ),
                    3 > 2
                        ? CustomButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                CarSelectPage.routeName,
                              );
                            },
                            child: Text(
                              "Бүгд",
                              style: GeneralTextStyles.bodyText(
                                context,
                                textColor: GeneralColors.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                VSpacer(),
                GridView.builder(
                  itemCount: provider.cars.length > 2 ? 2 : provider.cars.length,
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
                MenuItem(
                  icon: Icons.edit_outlined,
                  title: "Мэдээлэл шинэчлэх",
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileEdit.routeName);
                  },
                ),
                VSpacer(),
                MenuItem(
                  icon: Icons.lock_outline,
                  title: "Нууц үг солих",
                  onPressed: () {
                    Navigator.pushNamed(context, PasswordChange.routeName);
                  },
                ),
                VSpacer(),
                MenuItem(
                  icon: Icons.question_answer_outlined,
                  title: "Түгээмэл асуулт, хариулт",
                  onPressed: () {
                    Navigator.pushNamed(context, QaPage.routeName);
                  },
                ),
                VSpacer(),
                MenuItem(
                  icon: Icons.quick_contacts_dialer_outlined,
                  title: "Бидэнтэй холбогдох",
                  onPressed: () {
                    Navigator.pushNamed(context, Contact.routeName);
                  },
                ),
                VSpacer(),
                VSpacer(),
                VSpacer(),
                MenuItem(
                  icon: Icons.logout_outlined,
                  title: "Системээс гарах",
                  isLogout: true,
                  onPressed: () {
                    onLogout();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
