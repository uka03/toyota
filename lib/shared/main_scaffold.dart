import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/pages/home/home_page.dart';
import 'package:toyota/pages/profile/profile_page.dart';
import 'package:toyota/pages/service/service_page.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/provider/navigator_provider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/text_styles.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  static const String routeName = '/main';

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late final AuthProvider authProvider;
  late final NavigatorProvider navigatorProvider;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    navigatorProvider = Provider.of<NavigatorProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(builder: (context, provider, _) {
      final widgets = [
        HomePage(),
        ServicePage(),
        ProfilePage(),
      ];
      return Scaffold(
        backgroundColor: GeneralColors.whiteColor,
        appBar: CustomAppbar(),
        body: SafeArea(
          child: widgets[provider.selectedIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: GeneralColors.grayBGColor),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomItem(
                  context,
                  title: 'Home',
                  iconPath: 'assets/icons/ic_home.png',
                  onTap: provider.changeIndex,
                  index: 0,
                  selectedIndex: provider.selectedIndex,
                ),
                bottomItem(
                  context,
                  title: 'Service',
                  iconPath: 'assets/icons/ic_settings.png',
                  onTap: provider.changeIndex,
                  index: 1,
                  selectedIndex: provider.selectedIndex,
                ),
                bottomItem(
                  context,
                  title: 'Profile',
                  iconPath: 'assets/icons/ic_profile.png',
                  onTap: provider.changeIndex,
                  index: 2,
                  selectedIndex: provider.selectedIndex,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  InkWell bottomItem(
    BuildContext context, {
    required int index,
    required int selectedIndex,
    required String title,
    required String iconPath,
    required Function(int value) onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: selectedIndex == index ? GeneralColors.primaryColor : GeneralColors.grayColor,
            ),
            Text(
              title,
              style: GeneralTextStyles.titleText(
                context,
                textColor: selectedIndex == index ? GeneralColors.primaryColor : GeneralColors.grayColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
