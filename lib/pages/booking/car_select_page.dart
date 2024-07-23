import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/pages/booking/booking_order_page.dart';
import 'package:toyota/pages/booking/booking_page.dart';
import 'package:toyota/pages/booking/history_page.dart';
import 'package:toyota/pages/booking/provider/booking_provider.dart';
import 'package:toyota/pages/car/components/plate_number.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/constants.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class CarSelectPage extends StatefulWidget {
  const CarSelectPage({super.key});

  static const String routeName = '/cars';

  @override
  State<CarSelectPage> createState() => _CarSelectPageState();
}

class _CarSelectPageState extends State<CarSelectPage> {
  late final BookingProvider _bookingProvider;

  @override
  void initState() {
    super.initState();
    _bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      await _bookingProvider.getCars();
      dismissLoader();
    });
  }

  onTap(CarResponseData car, {String? type}) {
    final value = ModalRoute.of(context)?.settings.arguments as String? ?? type;
    switch (value) {
      case "booking":
        Navigator.pushNamed(
          context,
          BookingPage.routeName,
          arguments: car,
        );
        break;
      case "booking-order":
        Navigator.pushNamed(
          context,
          BookingOrderPage.routeName,
          arguments: car,
        );
        break;
      case "history":
        Navigator.pushNamed(
          context,
          HistoryPage.routeName,
          arguments: car,
        );
        break;
      case null:
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              backgroundColor: GeneralColors.primaryBGColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text("Үйлчилгээ сонгоно уу?"),
              titleTextStyle: GeneralTextStyles.titleText(context),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: services
                    .map(
                      (e) => CustomButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onTap(car, type: e.value);
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Image.asset(
                                e.icon,
                                width: 25,
                                height: 25,
                              ),
                              HSpacer.sm(),
                              Expanded(child: Text(e.title)),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: GeneralColors.whiteColor,
        appBar: CustomAppbar(),
        body: GeneralContainer(
          child: GridView.builder(
            itemCount: provider.cars.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final car = provider.cars[index];
              return CarItem(
                car: car,
                onTap: onTap,
              );
            },
          ),
        ),
      );
    });
  }
}

class CarItem extends StatelessWidget {
  const CarItem({
    super.key,
    required this.car,
    required this.onTap,
  });

  final CarResponseData car;
  final Function(CarResponseData car) onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        onTap(car);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GeneralColors.whiteColor,
              border: Border.all(),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                VSpacer(),
                Expanded(
                  child: car.imageWidget ??
                      Image.asset(
                        "assets/icons/ic_car.png",
                      ),
                ),
                Text(
                  car.modelName ?? car.name ?? "",
                  style: GeneralTextStyles.bodyText(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          car.plateNumber?.trim().isNotEmpty == true
              ? Positioned(
                  right: 10,
                  top: 10,
                  child: PlateNumber(plateNumber: car.plateNumber ?? ""),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
