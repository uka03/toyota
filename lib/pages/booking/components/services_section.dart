import 'package:flutter/material.dart';
import 'package:toyota/connection/model/service_response.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({
    super.key,
    required this.services,
    required this.onServiceSelected,
    this.isChoose = false,
    this.onTap,
  });
  final List<ServiceResponseData> services;
  final Function(ServiceResponseData service) onServiceSelected;
  final bool isChoose;
  final VoidCallback? onTap;
  final List<Color> colors = [
    Color(0xFF2196F3),
    Color(0xFFE91E63),
    Color(0xFF4CAF50),
    Color(0xFFFFC107),
    Color(0xFFF44336),
    Color(0xFF9E9E9E),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 10,
      children: [
        ...services.map((service) {
          final color = colors[((service.id ?? 1) - 1) % 6];
          return CustomButton(
            onPressed: () {
              onServiceSelected(service);
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: color.withOpacity(0.3)),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: color,
                  ),
                  HSpacer.sm(),
                  Text(
                    service.displayName ?? "",
                    style: GeneralTextStyles.bodyText(context),
                  ),
                  HSpacer.sm(),
                  isChoose
                      ? SizedBox()
                      : Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.black,
                        ),
                ],
              ),
            ),
          );
        }),
        !isChoose
            ? CustomButton(
                onPressed: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  padding: EdgeInsets.all(3),
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
