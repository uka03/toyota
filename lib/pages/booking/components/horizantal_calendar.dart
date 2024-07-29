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
      height: 120,
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
              width: 90,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? GeneralColors.primaryColor : Color(0xffF1F5F9),
                ),
                color: isSelected ? GeneralColors.whiteColor : Color(0xffF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${date.month}/${date.day}",
                    style: GeneralTextStyles.titleText(
                      context,
                      fontSize: 20,
                      textColor: isSelected ? GeneralColors.primaryColor : GeneralColors.blackColor,
                    ),
                  ),
                  Text(
                    getWeekDay(date.weekday),
                    style: GeneralTextStyles.bodyText(context, fontSize: 14, textColor: isSelected ? GeneralColors.primaryColor : GeneralColors.blackColor),
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
