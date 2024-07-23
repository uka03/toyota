import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/profile/provider/profile_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/keyboard_hider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/toasts.dart';
import 'package:toyota/utils/utils.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  static const String routeName = '/profile-edit';

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late final ProfileProvider _profileProvider;

  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _mailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _registerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      final user = await _profileProvider.getMe();
      _lastNameController.text = user?.lastName ?? "Мэдээлэл байхгүй";
      _firstNameController.text = user?.firstName ?? "Мэдээлэл байхгүй";
      _mailController.text = user?.email ?? "";
      _phoneController.text = user?.mobile ?? "";
      _registerController.text = user?.vat ?? "";
      dismissLoader();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    _registerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: GeneralColors.primaryBGColor,
      appBar: CustomAppbar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              HSpacer(),
              Expanded(
                child: PrimaryButton(
                  height: 50,
                  borderRadius: 10,
                  backgroundColor: GeneralColors.secondaryButton,
                  text: Text(
                    "Хадгалах",
                    style: GeneralTextStyles.titleText(
                      context,
                      textColor: GeneralColors.whiteColor,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      showLoader();
                      final response = await _profileProvider.updateMe(
                        email: _mailController.text,
                        mobile: _phoneController.text,
                      );
                      if (response.status?.toLowerCase() == "success" && context.mounted) {
                        Navigator.pop(context);
                        Toast.success(context, description: "Амжилттай хадгаллаа");
                      } else if (context.mounted) {
                        Toast.error(context, description: response.message ?? "Хадгалах үед алдаа гарлаа");
                      }
                      dismissLoader();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: KeyboardHider(
          child: GeneralContainer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GeneralColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        "assets/icons/ic_user.png",
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  VSpacer(size: 40),
                  Row(
                    children: [
                      Expanded(
                        child: ProfileInput(
                          label: 'Овог',
                          controller: _lastNameController,
                          enabled: false,
                        ),
                      ),
                      HSpacer(),
                      Expanded(
                        child: ProfileInput(
                          label: 'Нэр',
                          enabled: false,
                          controller: _firstNameController,
                        ),
                      ),
                    ],
                  ),
                  VSpacer(),
                  ProfileInput(
                    label: "Бүртэлийн дугаар",
                    enabled: false,
                    controller: _registerController,
                  ),
                  VSpacer(),
                  ProfileInput(
                    label: "Утасны дугаар",
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                  ),
                  VSpacer(),
                  ProfileInput(
                    keyboardType: TextInputType.emailAddress,
                    label: "И-мэйл хаяг",
                    controller: _mailController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInput extends StatelessWidget {
  ProfileInput({
    super.key,
    required this.label,
    required this.controller,
    this.enabled = true,
    this.isPassword = false,
    this.keyboardType,
    this.observeText = false,
    this.eyeClick,
  });

  final String label;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool observeText;
  final Function? eyeClick;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );
  final disableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: GeneralColors.grayColor,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: observeText,
      validator: (value) {
        if (enabled && (value == null || value.isEmpty)) {
          return "Заавал оруулна уу";
        }
        if (keyboardType == TextInputType.emailAddress && !value!.contains("@")) {
          return "И-мэйл хаяг зөв оруулна уу";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: GeneralTextStyles.titleText(context, fontSize: 14),
        hintText: label,
        border: border,
        errorBorder: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: disableBorder,
        focusedErrorBorder: border,
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye_outlined),
          onPressed: () {
            if (eyeClick != null) {
              eyeClick!();
            }
          },
        ),
      ),
    );
  }
}
