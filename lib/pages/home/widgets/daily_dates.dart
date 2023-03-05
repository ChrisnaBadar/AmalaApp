import 'package:amala/constants/my_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DailyDates extends StatelessWidget {
  const DailyDates({super.key});

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now().subtract(const Duration(days: 5)),
      initialSelectedDate: DateTime.now(),
      selectionColor: MyThemeData.primaryColor,
      selectedTextColor: MyThemeData.alternativeColor,
      onDateChange: (date) {},
      locale: "id_ID",
      daysCount: 8,
      inactiveDates: List.generate(
          2, (index) => DateTime.now().add(Duration(days: index + 1))),
    );
  }
}
