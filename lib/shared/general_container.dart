import 'package:flutter/material.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer({
    super.key,
    required this.child,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });
  final Widget child;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: top ?? 24,
          left: left ?? 24,
          right: right ?? 24,
          bottom: bottom ?? 24,
        ),
        child: child,
      ),
    );
  }
}
