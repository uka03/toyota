import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class Toast {
  Toast._();

  static void success(
    BuildContext context, {
    String? description,
    String? title,
  }) {
    FToast fToast = FToast();
    fToast.removeCustomToast();
    fToast.init(context);
    return fToast.showToast(
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP,
      isDismissable: true,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: GeneralColors.blackColor.withOpacity(0.05),
              offset: Offset(1, 0),
              blurRadius: 12,
              spreadRadius: 10,
            ),
          ],
          color: Color.fromARGB(255, 148, 210, 131),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/ic_success.png",
              width: 24,
              height: 24,
              color: GeneralColors.whiteColor,
            ),
            HSpacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "Амжилттай",
                    style: GeneralTextStyles.titleText(
                      context,
                      textColor: GeneralColors.whiteColor,
                    ),
                  ),
                  VSpacer.sm(),
                  Text(
                    description ?? "",
                    style: GeneralTextStyles.bodyText(
                      context,
                      textColor: GeneralColors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static void error(
    BuildContext context, {
    String? description,
    String? title,
  }) {
    FToast fToast = FToast();
    fToast.removeCustomToast();
    fToast.init(context);
    return fToast.showToast(
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP,
      isDismissable: true,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: GeneralColors.blackColor.withOpacity(0.05),
              offset: Offset(1, 0),
              blurRadius: 12,
              spreadRadius: 10,
            ),
          ],
          color: Color.fromARGB(255, 255, 101, 90),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/ic_error.png",
              width: 24,
              height: 24,
              color: GeneralColors.whiteColor,
            ),
            HSpacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "Уучлаарай",
                    style: GeneralTextStyles.titleText(context, textColor: GeneralColors.whiteColor),
                  ),
                  Column(
                    children: [
                      VSpacer.sm(),
                      Text(
                        description ?? "Алдаа гарлаа.",
                        style: GeneralTextStyles.bodyText(context, textColor: GeneralColors.whiteColor, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
