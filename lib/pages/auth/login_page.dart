import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/auth/components/auth_field.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/pages/auth/recovery_page.dart';
import 'package:toyota/pages/auth/register_page.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/components/custom_checkbox.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/components/secondary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/keyboard_hider.dart';
import 'package:toyota/shared/main_scaffold.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/toasts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyota/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthProvider authProvider;

  bool rememberMe = false;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    getLoginInfo();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final isRemember = prefs.getBool("saved") ?? false;
    if (token?.isNotEmpty == true && mounted) {
      Navigator.pushReplacementNamed(context, MainScaffold.routeName);
    }
    if (isRemember) {
      final phone = prefs.getString("phone");
      _phoneController.text = phone ?? "";
      final password = prefs.getString("password");
      _passwordController.text = password ?? "";
    }
    setState(() {
      rememberMe = isRemember;
    });
  }

  void onLogin() async {
    if (_formKey.currentState!.validate()) {
      showLoader();
      final response = await authProvider.login(
        _phoneController.text,
        _passwordController.text,
        rememberMe,
      );
      dismissLoader();
      if (response.status?.toLowerCase() == "success") {
        if (mounted) {
          Navigator.pushReplacementNamed(context, MainScaffold.routeName);
          Toast.success(
            context,
            description: "Амжилттай нэвтэрлээ.",
          );
        }
      } else {
        if (mounted) {
          Toast.error(
            context,
            description: 'Та нэвтрэх мэдээллээ дахин шалгана уу.',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.primaryBGColor,
      body: GeneralContainer(
        child: KeyboardHider(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 250,
                      ),
                      VSpacer(size: 50),
                      AuthTextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        icon: Image.asset(
                          "assets/icons/ic_profile.png",
                          color: GeneralColors.blackColor,
                          width: 20,
                        ),
                        hintText: "Хэрэглэгчийн нэр",
                      ),
                      VSpacer.sm(),
                      AuthTextField(
                        obscureText: _obscureText,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        icon: Image.asset(
                          "assets/icons/ic_lock.png",
                          width: 20,
                          color: GeneralColors.blackColor,
                        ),
                        suffixIcon: CustomButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Image.asset(
                            "assets/icons/ic_eye.png",
                            width: 20,
                            color: GeneralColors.blackColor,
                          ),
                        ),
                        hintText: "Нууц үг",
                      ),
                      VSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            onPressed: () {
                              setState(() {
                                rememberMe = !rememberMe;
                              });
                            },
                            child: Row(
                              children: [
                                CustomCheckBox(value: rememberMe),
                                HSpacer.sm(),
                                Text(
                                  "Сануулах",
                                  style: GeneralTextStyles.bodyText(
                                    context,
                                    textColor: GeneralColors.blackColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RecoveryPage.routeName);
                            },
                            child: Text(
                              "Нууц үгээ мартсан уу ?",
                              style: GeneralTextStyles.bodyText(
                                context,
                                textColor: GeneralColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    PrimaryButton(
                      borderRadius: 10,
                      text: Text(
                        "Нэвтрэх",
                        style: GeneralTextStyles.titleText(
                          context,
                          textColor: GeneralColors.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: onLogin,
                    ),
                    VSpacer.sm(),
                    SecondaryButton(
                      borderRadius: 10,
                      borderColor: GeneralColors.grayColor,
                      text: Text(
                        "Бүртгүүлэх",
                        style: GeneralTextStyles.titleText(
                          context,
                          textColor: GeneralColors.grayTextColor,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
