import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    this.icon,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final Widget? icon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(
      color: GeneralColors.grayBGColor,
    ));
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Заавал бөглөнө үү.';
        }

        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: icon,
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        prefixIconConstraints: BoxConstraints(
          minWidth: 20,
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: suffixIcon,
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 20,
        ),
        filled: true,
        fillColor: GeneralColors.grayBGColor,
        hintText: hintText,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
      ),
    );
  }
}
