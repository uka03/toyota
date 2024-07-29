import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/booking/provider/booking_provider.dart';
import 'package:toyota/pages/booking/web_viewer.dart';
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
  late final BookingProvider _bookingProvider;
  @override
  void initState() {
    super.initState();
    _bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final car = ModalRoute.of(context)!.settings.arguments as CarResponseData?;
      _bookingProvider.getHistory(car?.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: GeneralColors.primaryBGColor,
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
          child: GeneralContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Засварын түүх",
                    style: GeneralTextStyles.bodyText(context, fontSize: 20),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "Он сар",
                          style: GeneralTextStyles.titleText(
                            context,
                            fontSize: 14,
                            textColor: Color(0xFF8D8D8D),
                          ),
                        ),
                      ),
                    ),
                    HSpacer.lg(),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: Text(
                          "Үйлчилгээ",
                          style: GeneralTextStyles.titleText(
                            context,
                            fontSize: 14,
                            textColor: Color(0xFF8D8D8D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VSpacer(),
                provider.historyOrder.isNotEmpty == true
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.historyOrder.length,
                        separatorBuilder: (context, index) => VSpacer(),
                        itemBuilder: (context, index) {
                          final order = provider.historyOrder[index];
                          final date = DateTime.tryParse(order.date ?? "") ?? DateTime.now();
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, WebViewer.routeName, arguments: order.url);
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F8FC),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: GeneralColors.primaryColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      HSpacer.sm(),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(date),
                                        style: GeneralTextStyles.bodyText(context),
                                      ),
                                    ],
                                  ),
                                ),
                                HSpacer.lg(),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 30,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F8FC),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Text(
                                      order.description ?? "",
                                      style: GeneralTextStyles.bodyText(context),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
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
        ),
      );
    });
  }
}
