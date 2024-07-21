import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const String routeName = '/detail-page';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DefaultResponseData? data;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        data = ModalRoute.of(context)!.settings.arguments as DefaultResponseData?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: GeneralColors.primaryBGColor,
      body: GeneralContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.name ?? "",
                style: GeneralTextStyles.titleText(context, fontSize: 20),
              ),
              data?.description?.isNotEmpty == true
                  ? Text(
                      data?.description ?? "",
                      style: GeneralTextStyles.bodyText(context),
                    )
                  : SizedBox(),
              VSpacer(),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: data?.imageWidget ?? SizedBox(),
                ),
              ),
              VSpacer(),
              HtmlWidget(
                "<div> ${data?.body ?? ""} </div>",
                textStyle: GeneralTextStyles.titleText(
                  context,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
