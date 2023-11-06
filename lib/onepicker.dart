library onepicker;

import 'package:flutter/material.dart';
import 'package:onepicker/date_view.dart';

class OnePicker {
  // /// Returns [value] plus 1.
  // int addOne(int value) => value + 1;

  date(BuildContext context, {required ValueSetter<DateTime> onTap}) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CalendarMonthView(onTap: (value){
          onTap.call(value);
          Navigator.pop(context);
        },
          selectedColor: Colors.blue,
          bgColor: Colors.white,);
      },
    );
  }

}

