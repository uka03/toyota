import 'package:flutter/material.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  static const String routeName = '/history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.primaryBGColor,
      appBar: CustomAppbar(),
      body: GeneralContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Засварын түүх",
              style: GeneralTextStyles.bodyText(context, fontSize: 20),
            ),
            Divider(),
            VSpacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GeneralColors.grayBGColor,
              ),
              width: double.infinity,
              child: Text(
                "Үзлэгийн түүх байхгүй байна.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
