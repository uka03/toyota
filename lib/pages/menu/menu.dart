import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/auth/login_page.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/pages/menu/contact.dart';
import 'package:toyota/pages/menu/qa_page.dart';
import 'package:toyota/pages/profile/profile_edit.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/components/secondary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/provider/navigator_provider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  static const String routeName = '/menu';
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late final NavigatorProvider navigatorProvider;
  late final AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    navigatorProvider = Provider.of<NavigatorProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
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
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: GeneralContainer(
        child: Column(
          children: [
            MenuItem(
              icon: Icons.edit_outlined,
              title: "Мэдээлэл шинэчлэх",
              onPressed: () {
                Navigator.pushNamed(context, ProfileEdit.routeName);
              },
            ),
            // VSpacer(),
            // MenuItem(
            //   icon: Icons.lock_outline,
            //   title: "Нууц үг солих",
            //   onPressed: () {
            //     Navigator.pushNamed(context, PasswordChange.routeName);
            //   },
            // ),
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
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isLogout = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: isLogout ? GeneralColors.primaryColor : GeneralColors.grayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: isLogout ? GeneralColors.primaryColor : GeneralColors.secondaryColor,
            ),
            HSpacer(),
            Expanded(
              child: Text(
                title,
                style: GeneralTextStyles.titleText(
                  context,
                  textColor: isLogout ? GeneralColors.primaryColor : GeneralColors.blackColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
