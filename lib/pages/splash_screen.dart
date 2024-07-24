import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyota/pages/auth/login_page.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/main_scaffold.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      body: GeneralContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 250,
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: GeneralColors.primaryColor,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Image.asset(
                      "assets/icons/ic_car.png",
                      fit: BoxFit.contain,
                      height: 330,
                      width: 330,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  text: Text(
                    "Эхлэх",
                    style: GeneralTextStyles.titleText(
                      context,
                      textColor: GeneralColors.whiteColor,
                    ),
                  ),
                  width: 130,
                  borderRadius: 10,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString("token");
                    if (token?.isNotEmpty == true && context.mounted) {
                      Navigator.pushReplacementNamed(context, MainScaffold.routeName);
                    } else if (context.mounted) {
                      Navigator.pushReplacementNamed(context, LoginPage.routeName);
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
