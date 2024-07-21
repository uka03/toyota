import 'package:flutter/material.dart';
import 'package:toyota/connection/model/agent_response.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DealerPage extends StatefulWidget {
  const DealerPage({super.key});

  static const String routeName = '/dealer';

  @override
  State<DealerPage> createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerPage> {
  String phoneFormat(String phone) {
    if (phone.length >= 4) {
      phone = '${phone.substring(0, 4)}-${phone.substring(4)}';
    }

    return phone;
  }

  @override
  Widget build(BuildContext context) {
    final agent = ModalRoute.of(context)?.settings.arguments as AgentResponseData?;
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 52),
        child: Column(
          children: [
            VSpacer(
              size: 50,
            ),
            Container(
              child: AspectRatio(
                aspectRatio: 7 / 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: agent?.imageWidget,
                ),
              ),
            ),
            VSpacer(),
            Text(
              "Борлуулалтын менежер",
              style: TextStyle(
                color: GeneralColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              agent?.name ?? "",
              style: GeneralTextStyles.titleText(
                context,
                fontSize: 30,
              ),
            ),
            VSpacer(
              size: 28,
            ),
            InkWell(
              onTap: () async {
                Uri uri = Uri(scheme: 'tel', path: agent?.phone ?? "");
                if (await canLaunchUrl(uri) == true) {
                  launchUrl(uri);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [
                        Color(0xFFFB0203),
                        Color(0xFFD91920),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: GeneralColors.whiteColor,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      phoneFormat(agent?.phone ?? ""),
                      style: GeneralTextStyles.titleText(
                        context,
                        fontSize: 20,
                        textColor: GeneralColors.whiteColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
