import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/booking/components/custom_time_picker.dart';
import 'package:toyota/pages/booking/components/horizantal_calendar.dart';
import 'package:toyota/pages/booking/components/services_section.dart';
import 'package:toyota/pages/booking/provider/booking_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/primary_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/shared/keyboard_hider.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/toasts.dart';
import 'package:intl/intl.dart';
import 'package:toyota/utils/utils.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  static const String routeName = '/booking';

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late final BookingProvider _bookingProvider;

  final noteController = TextEditingController();

  DateTime? selectedDate;
  int hour = 9;
  int minute = 0;

  @override
  void initState() {
    super.initState();
    _bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      await _bookingProvider.getServices();
      dismissLoader();
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    _bookingProvider.selectedErvices = [];
    super.dispose();
  }

  onSave() async {
    if (selectedDate != null) {
      if (_bookingProvider.selectedErvices.isNotEmpty) {
        final car = ModalRoute.of(context)!.settings.arguments as CarResponseData?;
        dynamic data = {
          "car_id": car?.id,
          "schedule_date": DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toLocal()),
          "start_date": '${DateFormat('yyyy-MM-dd').format(selectedDate!)} ${DateFormat('HH:mm').format(DateTime(DateTime.now().year, 1, 1, hour, minute))}',
          "type_ids": _bookingProvider.selectedErvices.map((v) => v.id).toList(),
          'description': noteController.text,
        };
        await _bookingProvider.createBooking(data);
        if (mounted) {
          Toast.success(
            context,
            description: "Таны хүсэлтийг хүлээн авлаа. Үйлчилгээний төвөөс удахгүй холбогдох болно.",
          );
          Navigator.pop(context);
        }
      } else {
        Toast.error(context, description: "Та үйлчилгээ сонгох хэрэгтэй.");
      }
    } else {
      Toast.error(context, description: "Та өдрөө сонгох хэрэгтэй.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: GeneralColors.whiteColor,
        appBar: CustomAppbar(),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryButton(
              borderRadius: 10,
              height: 50,
              text: Text(
                "Хадгалах",
                style: GeneralTextStyles.titleText(
                  context,
                  textColor: GeneralColors.whiteColor,
                ),
              ),
              onPressed: onSave,
            ),
          ),
        ),
        body: KeyboardHider(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: GeneralContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Өдөр сонгох",
                    style: GeneralTextStyles.titleText(context),
                  ),
                  VSpacer(),
                  HorintalCalendar(
                    selectedDate: selectedDate,
                    onDateSelected: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                    dateBuilder: (int index) {
                      return DateTime.now().add(Duration(days: index + 1));
                    },
                  ),
                  VSpacer(),
                  Text(
                    "Цаг авах",
                    style: GeneralTextStyles.titleText(context),
                  ),
                  VSpacer(),
                  CustomTimePicker(
                    onChanged: (int hourV, int min) {
                      hour = hourV;
                      minute = min;
                    },
                  ),
                  VSpacer(),
                  Text(
                    "Үйлчилгээний төрөл",
                    style: GeneralTextStyles.titleText(context),
                  ),
                  VSpacer(),
                  ServicesSection(
                    services: provider.selectedErvices,
                    onServiceSelected: provider.setService,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 0,
                        builder: (context) {
                          return Container(
                            constraints: BoxConstraints(
                              minHeight: 300,
                            ),
                            decoration: BoxDecoration(
                                color: GeneralColors.whiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                )),
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: GeneralColors.grayColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Үйлчилгээ сонгох",
                                        style: GeneralTextStyles.titleText(context),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close),
                                      )
                                    ],
                                  ),
                                  ServicesSection(
                                    services: provider.services,
                                    onServiceSelected: provider.setService,
                                    isChoose: true,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  VSpacer(),
                  Text(
                    "Тэмдэглэл",
                    style: GeneralTextStyles.titleText(context),
                  ),
                  VSpacer.sm(),
                  TextFormField(
                    controller: noteController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Жишээ: 6 сарын өмнө сервест орсон",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: GeneralColors.grayBGColor,
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
