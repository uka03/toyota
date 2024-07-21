import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return BackdropFilter(
      key: Key("loader"),
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: Lottie.asset(
        'assets/anim/anim_loader.json',
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}
