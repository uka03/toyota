import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/connection/model/agent_response.dart';
import 'package:toyota/pages/car/components/dealer_item.dart';
import 'package:toyota/pages/car/provider/car_provider.dart';
import 'package:toyota/shared/components/custom_appbar.dart';
import 'package:toyota/shared/general_container.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';
import 'package:toyota/utils/utils.dart';

class CarDealers extends StatefulWidget {
  const CarDealers({super.key});

  static const String routeName = '/car-dealers';

  @override
  State<CarDealers> createState() => _CarDealersState();
}

class _CarDealersState extends State<CarDealers> {
  late final CarProvider _carProvider;
  @override
  void initState() {
    super.initState();
    _carProvider = Provider.of<CarProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoader();
      final type = ModalRoute.of(context)?.settings.arguments as String?;
      await _carProvider.getSalers(type);
      dismissLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CarProvider, List<AgentResponseData>>(
      selector: (context, provider) => provider.agents,
      builder: (context, items, _) {
        return Scaffold(
          backgroundColor: GeneralColors.primaryBGColor,
          appBar: CustomAppbar(),
          body: GeneralContainer(
            child: Column(
              children: [
                Text(
                  "Борлуулалтын менежерүүд",
                  style: GeneralTextStyles.titleText(context),
                ),
                VSpacer(),
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) => VSpacer(),
                    itemBuilder: (context, index) {
                      final agent = items[index];
                      return DealerItem(agent: agent);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
