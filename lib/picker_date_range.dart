import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// ================== Calendar View ===============================================
/// `const CustomCalendar({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   this.startEndDateChange,
///   this.minimumDate,
///   this.maximumDate,
///   required this.primaryColor,
/// })`
class CustomCalendar extends StatefulWidget {
  /// The minimum date that can be selected on the calendar
  final DateTime? minimumDate;

  /// The maximum date that can be selected on the calendar
  final DateTime? maximumDate;

  /// The initial start date to be shown on the calendar
  final DateTime? initialStartDate;

  /// The initial end date to be shown on the calendar
  final DateTime? initialEndDate;

  /// The primary color to be used in the calendar's color scheme
  final Color? primaryColor;

  /// A function to be called when the selected date range changes
  final Function(DateTime, DateTime)? startEndDateChange;

  const CustomCalendar({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    this.startEndDateChange,
    this.minimumDate,
    this.maximumDate,
     this.primaryColor,
  }) : super(key: key);

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  List<DateTime> dateList = <DateTime>[];

  DateTime currentMonthDate = DateTime.now();

  DateTime? startDate;

  DateTime? endDate;

  Color kPrimery = Colors.green;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 38,
                    width: 38,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(
                              currentMonthDate.year, currentMonthDate.month, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('MMMM yyyy').format(currentMonthDate).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black87
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 38,
                    width: 38,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year,
                              currentMonthDate.month + 2, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Row(
              children: getDaysNameUI(),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black26,
            margin: const EdgeInsets.only(left: 5, right: 5),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: getDaysNoUI(),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EEE').format(dateList[i]).toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Container(
            // width: Get.width*0.1255,
            width: MediaQuery.of(context).size.width*0.1255,
            height: 40,
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: isStartDateRadius(date) ? 2 : 0,
                          right: isEndDateRadius(date) ? 15 : 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: startDate != null && endDate != null
                              ? getIsItStartAndEndDate(date) ||
                              getIsInRange(date)
                              ? kPrimery.withOpacity(0.4)
                              : Colors.transparent
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: isStartDateRadius(date)
                                ? const Radius.circular(24.0)
                                : const Radius.circular(0.0),
                            topLeft: isStartDateRadius(date)
                                ? const Radius.circular(24.0)
                                : const Radius.circular(0.0),
                            topRight: isEndDateRadius(date)
                                ? const Radius.circular(24.0)
                                : const Radius.circular(0.0),
                            bottomRight: isEndDateRadius(date)
                                ? const Radius.circular(24.0)
                                : const Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (currentMonthDate.month == date.month) {
                      if (widget.minimumDate != null &&
                          widget.maximumDate != null) {
                        final DateTime newminimumDate = DateTime(
                            widget.minimumDate!.year,
                            widget.minimumDate!.month,
                            widget.minimumDate!.day - 1);
                        final DateTime newmaximumDate = DateTime(
                            widget.maximumDate!.year,
                            widget.maximumDate!.month,
                            widget.maximumDate!.day + 1);
                        if (date.isAfter(newminimumDate) &&
                            date.isBefore(newmaximumDate)) {
                          onDateClick(date);
                        }
                      } else if (widget.minimumDate != null) {
                        final DateTime newminimumDate = DateTime(
                            widget.minimumDate!.year,
                            widget.minimumDate!.month,
                            widget.minimumDate!.day - 1);
                        if (date.isAfter(newminimumDate)) {
                          onDateClick(date);
                        }
                      } else if (widget.maximumDate != null) {
                        final DateTime newmaximumDate = DateTime(
                            widget.maximumDate!.year,
                            widget.maximumDate!.month,
                            widget.maximumDate!.day + 1);
                        if (date.isBefore(newmaximumDate)) {
                          onDateClick(date);
                        }
                      } else {
                        onDateClick(date);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: getIsItStartAndEndDate(date)
                            ? kPrimery
                            : Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                        // border: Border.all(
                        //   color: getIsItStartAndEndDate(date)
                        //       ? Colors.white
                        //       : Colors.transparent,
                        //   width: 2,
                        // ),
                        // boxShadow: getIsItStartAndEndDate(date)
                        //     ? <BoxShadow>[
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.6),
                        //       blurRadius: 4,
                        //       offset: const Offset(0, 0)),
                        // ]
                        //     : null,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: getIsItStartAndEndDate(date)
                                ? Colors.white
                                : currentMonthDate.month == date.month
                                ? Colors.black
                                : Colors.grey.withOpacity(0.6),
                            // fontSize:
                            // MediaQuery.of(context).size.width > 360
                            //     ? 18
                            //     : 16,
                            // fontWeight: getIsItStartAndEndDate(date)
                            //     ? FontWeight.bold
                            //     : FontWeight.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 10,
                  left: 0,
                  child: Container(
                    height: 6,
                    width: 6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DateTime.now().day == date.day &&
                            DateTime.now().month == date.month &&
                            DateTime.now().year == date.year
                            ? getIsInRange(date)
                            ? Colors.white
                            : Colors.green
                            : Colors.transparent,
                        shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month &&
        startDate!.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month &&
        endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        final DateTime d = startDate!;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange!(startDate!, endDate!);
      } catch (_) {}
    });
  }
}



// ======================== Picker View ==========================================


/// A custom date range picker widget that allows users to select a date range.
/// `const CustomDateRangePicker({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   required this.primaryColor,
///   required this.backgroundColor,
///   required this.onApplyClick,
///   this.barrierDismissible = true,
///   required this.minimumDate,
///   required this.maximumDate,
///   required this.onCancelClick,
/// })`
class CustomDateRangePicker extends StatefulWidget {
  /// The minimum date that can be selected in the calendar.
  final DateTime? minimumDate;

  /// The maximum date that can be selected in the calendar.
  final DateTime? maximumDate;

  /// Whether the widget can be dismissed by tapping outside of it.
  final bool? barrierDismissible;

  /// The initial start date for the date range picker. If not provided, the calendar will default to the minimum date.
  final DateTime? initialStartDate;

  /// The initial end date for the date range picker. If not provided, the calendar will default to the maximum date.
  final DateTime? initialEndDate;

  /// The primary color used for the date range picker.
  final Color? primaryColor;

  /// The background color used for the date range picker.
  final Color? backgroundColor;

  /// A callback function that is called when the user applies the selected date range.
  final Function(DateTime, DateTime)? onApplyClick;

  /// A callback function that is called when the user cancels the selection of the date range.
  final Function()? onCancelClick;

  final bool showSelected;

  const CustomDateRangePicker({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
     this.primaryColor,
     this.backgroundColor,
     this.onApplyClick,
    this.barrierDismissible = true,
     this.minimumDate,
     this.maximumDate,
     this.onCancelClick,
     this.showSelected = true,
  }) : super(key: key);

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  DateTime? startDate;

  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: widget.showSelected,
              child:  Row(
                children: <Widget>[
                 GestureDetector(
                   onTap: (){
                     try {
                       widget.onCancelClick!();
                       Navigator.pop(context);
                     } catch (_) {}
                   },
                   child:  const SizedBox(
                     width: 50,
                     child: Icon(Icons.clear),
                   ),
                 ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'From',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          startDate != null
                              ? DateFormat('EEE, dd MMM')
                              .format(startDate!)
                              : '--/-- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'To',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          endDate != null
                              ? DateFormat('EEE, dd MMM')
                              .format(endDate!)
                              : '--/-- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      try {
                        widget.onApplyClick!(startDate!, endDate!);
                        Navigator.pop(context);
                      } catch (_) {}
                    },
                    child: const SizedBox(
                      width: 50,
                      child: Icon(Icons.check),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
            CustomCalendar(
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              initialEndDate: widget.initialEndDate,
              initialStartDate: widget.initialStartDate,
              primaryColor: widget.primaryColor,
              startEndDateChange:
                  (DateTime startDateData, DateTime endDateData) {
                setState(() {
                  startDate = startDateData;
                  endDate = endDateData;
                });
              },
            ),
            Visibility(
              visible: false,
              child:  Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(24.0)),
                        ),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: widget.primaryColor!)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(24.0)),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                widget.primaryColor),
                          ),
                          onPressed: () {
                            try {
                              widget.onCancelClick!();
                              Navigator.pop(context);
                            } catch (_) {}
                          },
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(24.0)),
                        ),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                BorderSide(color: widget.primaryColor!)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(24.0)),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                widget.primaryColor),
                          ),
                          onPressed: () {
                            try {
                              widget.onApplyClick!(startDate!, endDate!);
                              Navigator.pop(context);
                            } catch (_) {}
                          },
                          child: const Center(
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Displays a custom date range picker dialog box.
/// `context` The context in which to show the dialog.
/// `dismissible` A boolean value indicating whether the dialog can be dismissed by tapping outside of it.
/// `minimumDate` A DateTime object representing the minimum allowable date that can be selected in the date range picker.
/// `maximumDate` A DateTime object representing the maximum allowable date that can be selected in the date range picker.
/// `startDate` A nullable DateTime object representing the initial start date of the date range selection.
/// `endDate` A nullable DateTime object representing the initial end date of the date range selection.
/// `onApplyClick` A function that takes two DateTime parameters representing the selected start and end dates, respectively, and is called when the user taps the "Apply" button.
/// `onCancelClick` A function that is called when the user taps the "Cancel" button.
/// `backgroundColor` The background color of the dialog.
/// `primaryColor` The primary color of the dialog.
/// `fontFamily` The font family to use for the text in the dialog.