import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/extensions/string_extensions.dart';
import 'package:toyota/pages/auth/components/auth_field.dart';
import 'package:toyota/pages/auth/components/custom_pincode.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/keyboard_hider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/toasts.dart';
import 'package:toyota/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthProvider authProvider;

  final _formKey = GlobalKey<FormState>();

  final controller = PageController();
  final _phoneController = TextEditingController();
  final _otp = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool obscureText = true;
  bool obscureTextConfirm = true;

  final otpFocus = FocusNode();

  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otp.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    otpFocus.dispose();
    super.dispose();
  }

  onTap() async {
    switch (controller.page) {
      case 0:
        if (_formKey.currentState?.validate() == true) {
          showLoader();
          final response = await authProvider.checkMobile(_phoneController.text);

          if (response?.status == "success" && mounted) {
            controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
            FocusScope.of(context).unfocus();
            await authProvider.sendOtp(_phoneController.text);
            dismissLoader();
            setState(() {
              selectedPage = 1;
            });
          } else {
            dismissLoader();
            if (mounted) {
              Toast.error(
                context,
                description: response?.message,
              );
            }
          }
        }

        break;
      case 1:
        if (_otp.text.length == 4) {
          showLoader();
          final response = await authProvider.verifyOtp(_phoneController.text, _otp.text);
          if (response && mounted) {
            dismissLoader();
            controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
            FocusScope.of(context).unfocus();
            setState(() {
              selectedPage = 2;
            });
          } else {
            dismissLoader();
            if (mounted) {
              Toast.error(
                context,
                description: "OTP буруу байна.",
              );
            }
          }
        } else {
          Toast.error(
            context,
            description: "OTP бүрэн оруулна уу?",
          );
        }
      case 2:
        if (_formKey.currentState?.validate() == true) {
          showLoader();
          controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
          setState(() {
            selectedPage = 3;
          });
          dismissLoader();
        }
        break;
      case 3:
        if (_formKey.currentState?.validate() == true) {
          showLoader();
          final data = RegisterData(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            mobile: _phoneController.text,
            password: _confirmPasswordController.text,
          );
          final repsonse = await authProvider.register(data);
          if (repsonse?.code != 0) {
            dismissLoader();
            if (mounted) {
              Toast.success(
                context,
                description: repsonse?.message,
              );
            }
          } else {
            dismissLoader();
            if (mounted) {
              Navigator.pop(context);
              Toast.success(
                context,
                description: "Таны хүсэлтийг хүлээн авлаа. Бүртгэл хийгдсэн үед мэдэгдэл очих болно.",
              );
            }
          }
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.primaryBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GeneralColors.primaryBGColor,
      ),
      body: GeneralContainer(
        child: KeyboardHider(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                    child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    phoneField(),
                    otpField(context),
                    infoField(context),
                    passwordField(context)
                  ],
                )),
                Column(
                  children: [
                    PrimaryButton(
                      borderRadius: 10,
                      text: Text(
                        selectedPage != 3 ? "Үргэлжлүүлэх" : "Илгээх",
                        style: GeneralTextStyles.titleText(
                          context,
                          textColor: GeneralColors.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: onTap,
                    ),
                    VSpacer.sm(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Нууц үг үүсгэх",
          style: GeneralTextStyles.titleText(
            context,
          ),
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Нууц үг",
          controller: _passwordController,
          obscureText: obscureText,
          keyboardType: TextInputType.visiblePassword,
          validator: (p0) {
            return p0.isGoodPassword();
          },
          suffixIcon: CustomEyeBtn(
            value: obscureText,
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Нууц үг давтах",
          controller: _confirmPasswordController,
          obscureText: obscureTextConfirm,
          keyboardType: TextInputType.visiblePassword,
          validator: (p0) {
            if (_confirmPasswordController.text != _passwordController.text) {
              return 'Нууц үг буруу байна.';
            }
          },
          suffixIcon: CustomEyeBtn(
            value: obscureTextConfirm,
            onTap: () {
              setState(() {
                obscureTextConfirm = !obscureTextConfirm;
              });
            },
          ),
        ),
      ],
    );
  }

  Column infoField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Хувийн мэдээлэл",
          style: GeneralTextStyles.titleText(
            context,
          ),
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Овог",
          keyboardType: TextInputType.name,
          controller: _lastNameController,
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Нэр",
          controller: _firstNameController,
          keyboardType: TextInputType.name,
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Утас",
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
        VSpacer(),
        AuthTextField(
          hintText: "Имайл хаяг",
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (p0) {
            if (!p0.isValidEmail()) {
              return 'Имайл хаяг буруу байна.';
            }
          },
        ),
      ],
    );
  }

  Column phoneField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VSpacer(size: 50),
        Image.asset(
          "assets/images/logo.png",
          width: 250,
        ),
        VSpacer(size: 100),
        AuthTextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          icon: Image.asset(
            "assets/icons/ic_profile.png",
            width: 20,
          ),
          hintText: "Утасны дугаар оруулах",
        ),
        VSpacer.sm(),
      ],
    );
  }

  Column otpField(BuildContext context) {
    return Column(
      children: [
        VSpacer(size: 50),
        Text(
          "Таны ${_phoneController.text} дугаарт илгээгдсэн  \n 4 оронтой кодыг оруулна уу",
          textAlign: TextAlign.center,
          style: GeneralTextStyles.titleText(
            context,
            fontWeight: FontWeight.normal,
          ),
        ),
        VSpacer(),
        CustomPincode(
          controller: _otp,
          onFinished: (String value) {
            onTap();
          },
        ),
        VSpacer(),
        InkWell(
          onTap: () async {
            await authProvider.sendOtp(_phoneController.text);
          },
          borderRadius: BorderRadius.circular(40),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              "Дахин илгээх",
              style: GeneralTextStyles.bodyText(context, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomEyeBtn extends StatelessWidget {
  const CustomEyeBtn({
    super.key,
    required this.value,
    required this.onTap,
  });

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onTap,
      child: Image.asset(
        "assets/icons/ic_eye${value ? "" : "_slash"}.png",
        width: 25,
      ),
    );
  }
}
