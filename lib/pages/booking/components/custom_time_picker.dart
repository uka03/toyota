import 'package:flutter/cupertino.dart';
import 'package:toyota/utils/colors.dart';
import 'package:toyota/utils/spacer.dart';
import 'package:toyota/utils/text_styles.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    required this.onChanged,
  });
  final Function(
    int hour,
    int min,
  ) onChanged;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  int min = 0;
  int hour = 9;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(color: GeneralColors.grayBGColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            child: CupertinoPicker.builder(
              itemExtent: 50,
              childCount: 10,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.5,
              selectionOverlay: SizedBox(),
              onSelectedItemChanged: (value) {
                hour = value + 9;
                widget.onChanged(hour, min);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    (index + 9).toString(),
                    style: GeneralTextStyles.titleText(context, fontSize: 24),
                  ),
                );
              },
            ),
          ),
          HSpacer(),
          Text(
            "цаг",
            style: GeneralTextStyles.titleText(context, fontSize: 24),
          ),
          HSpacer(size: 20),
          SizedBox(
            width: 50,
            child: CupertinoPicker.builder(
              itemExtent: 40,
              childCount: 4,
              diameterRatio: 1,
              useMagnifier: true,
              magnification: 1.5,
              selectionOverlay: SizedBox(),
              onSelectedItemChanged: (value) {
                min = value * 15;
                widget.onChanged(hour, min);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    (index * 15).toString(),
                    style: GeneralTextStyles.titleText(context, fontSize: 24),
                  ),
                );
              },
            ),
          ),
          HSpacer(),
          Text(
            "мин",
            style: GeneralTextStyles.titleText(context, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
