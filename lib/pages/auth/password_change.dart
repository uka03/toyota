import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyota/pages/profile/profile_edit.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/keyboard_hider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/toasts.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  static const String routeName = '/password-change';

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool oldObserved = false;
  bool newObserved = false;
  bool confirmObserved = false;

  changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("passord"));
    if (prefs.getString('password') == oldPassword.text) {
    } else {
      if (mounted) {
        Toast.error(context, description: "Нууц үг буруу байна");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: KeyboardHider(
        child: GeneralContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Нууц үг солих",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              VSpacer(),
              ProfileInput(
                label: "Хуучин нууц үг",
                controller: oldPassword,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                observeText: oldObserved,
                eyeClick: () {
                  setState(() {
                    oldObserved = !oldObserved;
                  });
                },
              ),
              VSpacer(),
              ProfileInput(
                label: "Шинэ нууц үг",
                controller: newPassword,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                observeText: newObserved,
                eyeClick: () {
                  setState(() {
                    newObserved = !newObserved;
                  });
                },
              ),
              VSpacer(),
              ProfileInput(
                label: "Шинэ нууц үг давтах",
                controller: confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                observeText: confirmObserved,
                eyeClick: () {
                  setState(() {
                    confirmObserved = !confirmObserved;
                  });
                },
              ),
              VSpacer(),
              PrimaryButton(
                backgroundColor: GeneralColors.primaryColor,
                borderRadius: 10,
                height: 50,
                text: Text(
                  "Нууц үг солих",
                  style: GeneralTextStyles.titleText(
                    context,
                    textColor: GeneralColors.whiteColor,
                  ),
                ),
                onPressed: changePassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
