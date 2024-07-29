import 'package:flutter/material.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  static const String routeName = '/contact-page';

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.whiteColor,
      appBar: CustomAppbar(),
      body: GeneralContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Бидэнтэй холбогдох",
                style: GeneralTextStyles.titleText(context, fontSize: 20),
              ),
              VSpacer(),
              ContactPhoneItem(
                title: "Toyota автомашин",
                phone: "+976 7577-4444",
                icon: Icons.car_rental,
                onPressed: () async {
                  Uri uri = Uri(scheme: 'tel', path: "7577-4444");
                  if (await canLaunchUrl(uri) == true) {
                    launchUrl(uri);
                  }
                },
              ),
              VSpacer(),
              ContactPhoneItem(
                title: "Toyota засвар үйлчилгээ, сэлбэг",
                phone: "+976 7577-0000",
                icon: Icons.car_repair,
                onPressed: () async {
                  Uri uri = Uri(scheme: 'tel', path: "7577-0000");
                  if (await canLaunchUrl(uri) == true) {
                    launchUrl(uri);
                  }
                },
              ),
              VSpacer(),
              ContactPhoneItem(
                title: "Bridgestone дугуй, OZ обуд",
                phone: "+976 7507-0000",
                icon: Icons.blur_circular_outlined,
                onPressed: () async {
                  Uri uri = Uri(scheme: 'tel', path: "7507-0000");
                  if (await canLaunchUrl(uri) == true) {
                    launchUrl(uri);
                  }
                },
              ),
              VSpacer(),
              ContactPhoneItem(
                title: "Toyota-Таванбогд Хаяг",
                phone: "СБД, 1 хороо, Олимпийн гудамж, Toyota төв",
                icon: Icons.location_pin,
                trailIcon: Icons.map_outlined,
                onPressed: () async {
                  Uri? uri = Uri.tryParse("https://maps.app.goo.gl/QAxG2piTfmCRtCBs7");
                  if (uri != null) {
                    if (await canLaunchUrl(uri) == true) {
                      launchUrl(uri);
                    }
                  }
                },
              ),
              VSpacer(),
              ContactPhoneItem(
                title: "Toyota Цахим хуудас",
                phone: "www.toyota-tavanbogd.com",
                icon: Icons.language,
                trailIcon: Icons.ads_click,
                onPressed: () async {
                  Uri? uri = Uri.tryParse("https://toyota-tavanbogd.mn");
                  if (uri != null) {
                    if (await canLaunchUrl(uri) == true) {
                      launchUrl(uri);
                    }
                  }
                },
              ),
              VSpacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactPhoneItem extends StatelessWidget {
  const ContactPhoneItem({
    super.key,
    required this.title,
    required this.phone,
    required this.icon,
    required this.onPressed,
    this.trailIcon,
  });
  final String title;
  final String phone;
  final IconData icon;
  final VoidCallback onPressed;
  final IconData? trailIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GeneralTextStyles.bodyText(
                      context,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    phone,
                    style: GeneralTextStyles.titleText(context, fontSize: 14),
                  )
                ],
              ),
            ),
            HSpacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(5),
              child: Icon(
                trailIcon ?? Icons.phone,
                size: 20,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
