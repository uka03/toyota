import 'package:flutter/material.dart';
import 'package:toyota/connection/model/agent_response.dart';
import 'package:toyota/pages/car/dealer_page.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class DealerItem extends StatelessWidget {
  const DealerItem({
    super.key,
    required this.agent,
  });

  final AgentResponseData agent;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        Navigator.pushNamed(context, DealerPage.routeName, arguments: agent);
        // Uri uri = Uri(scheme: 'tel', path: agent.phone);
        // if (await canLaunchUrl(uri) == true) {
        //   launchUrl(uri);
        // }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: GeneralColors.grayBGColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: agent.imageWidget,
              ),
            ),
            HSpacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Борлуулалтын менежер",
                    style: GeneralTextStyles.bodyText(context),
                  ),
                  VSpacer.sm(),
                  Text(
                    agent.name ?? '',
                    style: GeneralTextStyles.titleText(context),
                  ),
                  VSpacer.sm(),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20,
                      ),
                      HSpacer.sm(),
                      Expanded(
                        child: Text(
                          agent.phone ?? '',
                          style: GeneralTextStyles.titleText(context),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
