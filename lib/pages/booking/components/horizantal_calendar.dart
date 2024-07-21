import 'package:flutter/material.dart';
import 'package:toyota/shared/components/custom_button.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class HorintalCalendar extends StatelessWidget {
  const HorintalCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.dateBuilder,
    this.itemCount,
  });

  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime Function(int index) dateBuilder;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    String getWeekDay(int value) {
      switch (value) {
        case 1:
          return "Даваа";
        case 2:
          return "Мягмар";
        case 3:
          return "Лхагва";
        case 4:
          return "Пүрэв";
        case 5:
          return "Баасан";
        case 6:
          return "Бямба";
        case 7:
          return "Ням";
        default:
          return "";
      }
    }

    return SizedBox(
      height: 90,
      child: ListView.separated(
        itemCount: itemCount ?? 14,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => HSpacer(),
        itemBuilder: (context, index) {
          final date = dateBuilder(index);
          final isSelected = selectedDate?.day == date.day && selectedDate?.month == date.month;
          return CustomButton(
            onPressed: () {
              onDateSelected(date);
            },
            child: Container(
              width: 80,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? GeneralColors.primaryColor : GeneralColors.blackColor,
                ),
                color: isSelected ? GeneralColors.primaryColor : GeneralColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    getWeekDay(date.weekday),
                    style: GeneralTextStyles.bodyText(context, fontSize: 12, textColor: isSelected ? GeneralColors.whiteColor : GeneralColors.blackColor),
                  ),
                  Text(
                    "${date.month}/${date.day}",
                    style: GeneralTextStyles.titleText(
                      context,
                      fontSize: 24,
                      textColor: isSelected ? GeneralColors.whiteColor : GeneralColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
