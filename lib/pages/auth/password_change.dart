import 'package:flutter/material.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/utils/colors.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  static const String routeName = '/password-change';

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
