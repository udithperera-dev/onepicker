library onepicker;

import 'package:flutter/material.dart';
import 'package:onepicker/country.dart';
import 'package:onepicker/date_view.dart';
import 'package:onepicker/picker_date_range.dart';

class OnePicker {
  // /// Returns [value] plus 1.
  // int addOne(int value) => value + 1;

  date(
    BuildContext context, {
    required ValueSetter<DateTime> onTap,
    Color selectedColor = Colors.green,
    Color bgColor = Colors.white,
  }) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CalendarMonthView(
          onTap: (value) {
            onTap.call(value);
            Navigator.pop(context);
          },
          selectedColor: selectedColor,
          bgColor: Colors.white,
        );
      },
    );
  }

  dateRange(BuildContext context, {Function(DateTime, DateTime)? onTap}) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomDateRangePicker(
          barrierDismissible: true,
          minimumDate: DateTime.now().subtract(const Duration(days: 30)),
          maximumDate: DateTime.now().add(const Duration(days: 30)),
          // initialEndDate: endDate,
          // initialStartDate: startDate,
          backgroundColor: Colors.white,
          primaryColor: Colors.green,
          onApplyClick: (start, end) {
            onTap!.call(start, end);
            // setState(() {
            //   endDate = end;
            //   startDate = start;
            // });
          },
          onCancelClick: () {
            // setState(() {
            //   endDate = null;
            //   startDate = null;
            // });
          },
        );
      },
    );
  }

  country(
    BuildContext context, {
    required ValueSetter<Country> onTap,
    Color selectedColor = Colors.green,
    Color bgColor = Colors.white,
  }) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CoungtryView(
          onTap: (value) {
            onTap.call(value);
            Navigator.pop(context);
          },
          selectedColor: selectedColor,
          bgColor: Colors.white,
          init: countries.first,
        );
      },
    );
  }
}
