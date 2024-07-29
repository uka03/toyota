import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/car/car_page.dart';
import 'package:toyota/pages/car/provider/car_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class NewCars extends StatefulWidget {
  const NewCars({super.key});

  static const String routeName = '/new-cars';

  @override
  State<NewCars> createState() => _NewCarsState();
}

class _NewCarsState extends State<NewCars> {
  late final CarProvider _carProvider;
  bool isToyotaQ = false;

  @override
  void initState() {
    super.initState();
    _carProvider = Provider.of<CarProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      final response = ModalRoute.of(context)?.settings.arguments as String?;
      if (response == 'toyotaQ') {
        await _carProvider.getToyotaQCars();
      } else {
        await _carProvider.getNewCars();
      }
      setState(() {
        isToyotaQ = response == 'toyotaQ';
      });
      dismissLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    final response = ModalRoute.of(context)?.settings.arguments as String?;
    return Consumer<CarProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: GeneralColors.primaryBGColor,
        appBar: CustomAppbar(
          title: response == "toyotaQ"
              ? Image.asset(
                  "assets/images/img_toyotaQ.png",
                  width: 150,
                )
              : null,
        ),
        body: GeneralContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isToyotaQ ? "Toyota-Q автомашин худалдаа" : "Шинэ автомашин худалдаа",
                style: GeneralTextStyles.titleText(context),
              ),
              VSpacer(),
              Expanded(
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
                        onTap: (car) {
                          Navigator.pushNamed(
                            context,
                            CarPage.routeName,
                            arguments: car,
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
