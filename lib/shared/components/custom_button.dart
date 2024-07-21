import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.child, this.onPressed, this.behavior});

  final Widget child;
  final VoidCallback? onPressed;
  final HitTestBehavior? behavior;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: behavior ?? HitTestBehavior.opaque,
      onTap: onPressed,
      child: child,
    );
  }
}
