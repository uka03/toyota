import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/category_response.dart';
import 'package:toyota/connection/model/part_response.dart';
import 'package:toyota/pages/car/components/part_item.dart';
import 'package:toyota/pages/car/provider/car_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class CarParts extends StatefulWidget {
  const CarParts({super.key});

  static const String routeName = '/car-parts';

  @override
  State<CarParts> createState() => _CarPartsState();
}

class _CarPartsState extends State<CarParts> {
  late final CarProvider _carProvider;

  @override
  void initState() {
    super.initState();
    _carProvider = Provider.of<CarProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      final category = ModalRoute.of(context)?.settings.arguments as CategoryResponseData?;
      await _carProvider.getParts(category?.id);
      dismissLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as CategoryResponseData?;
    return Selector<CarProvider, List<PartResponseData>>(
        selector: (p0, p1) => p1.parts,
        builder: (context, items, _) {
          return Scaffold(
            backgroundColor: GeneralColors.primaryBGColor,
            appBar: CustomAppbar(),
            body: GeneralContainer(
              child: Column(
                children: [
                  Text(
                    category?.name ?? "",
                    style: GeneralTextStyles.titleText(context, fontSize: 20),
                  ),
                  VSpacer(),
                  Expanded(
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) => VSpacer(),
                      itemBuilder: (context, index) {
                        final part = items[index];
                        return PartItem(part: part);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
