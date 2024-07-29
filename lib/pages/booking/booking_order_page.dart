import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_planner/time_planner.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/connection/model/order_response.dart';
import 'package:toyota/pages/booking/components/horizantal_calendar.dart';
import 'package:toyota/pages/booking/provider/booking_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class BookingOrderPage extends StatefulWidget {
  const BookingOrderPage({super.key});

  static const String routeName = '/booking_order';

  @override
  State<BookingOrderPage> createState() => _BookingOrderPageState();
}

class _BookingOrderPageState extends State<BookingOrderPage> {
  late final BookingProvider _bookingProvider;
  CarResponseData? car;

  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      car = ModalRoute.of(context)?.settings.arguments as CarResponseData?;
      showLoader();
      await _bookingProvider.getBookingOrder(car?.id, selectedDate);
      dismissLoader();
    });
  }

  List<TimePlannerTask> getRows(List<OrderResponseData> orders) {
    final List<TimePlannerTask> rows = [];
    for (var order in orders) {
      final orderDuration = double.tryParse(order.typeTimeTotal ?? "0") ?? 0.5;
      final time = DateTime.tryParse(order.startDate ?? "0");
      final row = TimePlannerTask(
        widthTask: (MediaQuery.of(context).size.width * 0.68),
        minutesDuration: (60 * (orderDuration <= 0 ? 0.5 : orderDuration)).toInt(),
        color: _getOrderBackgroundColor(order),
        dateTime: TimePlannerDateTime(day: 0, hour: time?.hour ?? 9, minutes: time?.minute ?? 0),
        child: InkWell(
          onDoubleTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: GeneralColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: GeneralColors.whiteColor,
                  ),
                ),
                actionsAlignment: MainAxisAlignment.center,
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                insetPadding: EdgeInsets.zero,
                content: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Та цагаа цуцлах уу?",
                        style: GeneralTextStyles.titleText(
                          context,
                          textColor: GeneralColors.whiteColor,
                          fontSize: 16,
                        ),
                      ),
                      VSpacer(),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: GeneralColors.whiteColor),
                                  color: GeneralColors.whiteColor.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Үгүй",
                                    style: GeneralTextStyles.titleText(
                                      context,
                                      fontSize: 14,
                                      textColor: GeneralColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          HSpacer(),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: GeneralColors.whiteColor),
                                color: GeneralColors.whiteColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Цуцлах",
                                  style: GeneralTextStyles.titleText(
                                    context,
                                    fontSize: 14,
                                    textColor: GeneralColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _getStatusText(order),
                      style: GeneralTextStyles.titleText(
                        context,
                        textColor: GeneralColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      rows.add(row);
    }
    return rows;
  }

  Color _getOrderBackgroundColor(OrderResponseData item) {
    Color result = Color(0xFFEDA519);

    switch (item.state) {
      case 'draft':
        result = Color(0xFFEDA519);
        break;
      case 'done':
        result = Color(0xFF0E8F72);
        break;
      case 'cancel':
        result = GeneralColors.primaryColor;
        break;
    }

    return result;
  }

  String _getStatusText(OrderResponseData item) {
    String result = '';

    switch (item.state) {
      case 'draft':
        result = 'Таны авсан цаг баталгаажаагүй байна.';
        break;
      case 'done':
        result = 'Таны авсан цаг баталгаажсан байна.';
        break;
      case 'cancel':
        result = 'Таны авсан цаг цуцлагдсан байна.';
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: GeneralColors.whiteColor,
        appBar: CustomAppbar(),
        body: GeneralContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorintalCalendar(
                selectedDate: selectedDate,
                itemCount: 15,
                onDateSelected: (date) {
                  _bookingProvider.getBookingOrder(car?.id, date);
                  setState(() {
                    selectedDate = date;
                  });
                },
                dateBuilder: (int index) {
                  return DateTime.now().add(Duration(days: index));
                },
              ),
              VSpacer(),
              Expanded(
                child: TimePlanner(
                  startHour: 9,
                  endHour: 23,
                  setTimeOnAxis: true,
                  use24HourFormat: true,
                  currentTimeAnimation: false,
                  style: TimePlannerStyle(
                    cellHeight: 50,
                    cellWidth: (MediaQuery.of(context).size.width * 0.70).toInt(),
                    dividerColor: Colors.black,
                    showScrollBar: false,
                    horizontalTaskPadding: 10,
                  ),
                  tasks: getRows(provider.bookingOrder),
                  headers: [
                    TimePlannerTitle(
                      title: "Цагийн хуваарь",
                      titleStyle: GeneralTextStyles.titleText(
                        context,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
