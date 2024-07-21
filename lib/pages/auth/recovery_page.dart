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

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  static const String routeName = '/recovery';

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _otp = TextEditingController();
  late final AuthProvider authProvider;
  int selectedIndex = 0;
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool isSame = true;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  onTap() async {
    FocusScope.of(context).unfocus();
    switch (selectedIndex) {
      case 0:
        if (_formKey.currentState?.validate() == true) {
          final response = await authProvider.checkMobile(_phoneController.text, type: "recovery");
          if (response?.status == "success" && mounted) {
            await authProvider.sendOtp(_phoneController.text);
            setState(() {
              selectedIndex = 1;
            });
          } else {
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
          final response = await authProvider.verifyOtp(_phoneController.text, _otp.text);
          if (response && mounted) {
            FocusScope.of(context).unfocus();
            setState(() {
              selectedIndex = 2;
            });
          } else {
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
        break;
      case 2:
        if (_formKey.currentState?.validate() == true) {
          if (_passwordController.text == _passwordConfirmController.text) {
            final response = await authProvider.updatePassword(_phoneController.text, _passwordConfirmController.text);
            if (response.status == "success" && mounted) {
              Toast.success(
                context,
                description: "Нууц үг амжилтай шинжилдэгдлээ.",
              );
              Navigator.pop(context);
            } else {
              if (mounted) {
                Toast.error(
                  context,
                  description: response.error ?? response.message ?? "Алдаа гарлаа.",
                );
              }
            }
          }
          setState(() {
            isSame = _passwordController.text == _passwordConfirmController.text;
          });
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      phoneField(),
      otpField(context),
      passwordField(),
    ];
    return Scaffold(
      backgroundColor: GeneralColors.primaryBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GeneralColors.primaryBGColor,
      ),
      body: KeyboardHider(
        child: GeneralContainer(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(child: children[selectedIndex]),
                PrimaryButton(
                  borderRadius: 10,
                  text: Text(
                    selectedIndex != 2 ? "Үргэлжлүүлэх" : "Дуусгах",
                    style: GeneralTextStyles.titleText(
                      context,
                      textColor: GeneralColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: onTap,
                )
              ],
            ),
          ),
        ),
      ),
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

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VSpacer(size: 50),
        Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 250,
          ),
        ),
        VSpacer(size: 50),
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
          validator: (value) {
            return value.isGoodPassword();
          },
        ),
        VSpacer(),
        AuthTextField(
          obscureText: _obscureConfirmText,
          controller: _passwordConfirmController,
          keyboardType: TextInputType.visiblePassword,
          icon: Image.asset(
            "assets/icons/ic_lock.png",
            width: 20,
            color: GeneralColors.blackColor,
          ),
          suffixIcon: CustomButton(
            onPressed: () {
              setState(() {
                _obscureConfirmText = !_obscureConfirmText;
              });
            },
            child: Image.asset(
              "assets/icons/ic_eye.png",
              width: 20,
              color: GeneralColors.blackColor,
            ),
          ),
          hintText: "Нууц үг давтах",
          validator: (value) {
            return value.isGoodPassword();
          },
        ),
        VSpacer.sm(),
        !isSame
            ? Text(
                "Нууц үг адилхан байх ёстой",
                style: GeneralTextStyles.bodyText(
                  context,
                  textColor: Colors.red,
                  fontSize: 14,
                ),
              )
            : SizedBox()
      ],
    );
  }
}
