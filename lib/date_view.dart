import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}


// ignore: must_be_immutable
class CalendarMonthView extends StatefulWidget {
  ValueSetter<DateTime> onTap;
  Color bgColor;
  Color selectedColor;

  CalendarMonthView({Key? key, required this.onTap, required this.bgColor, required this.selectedColor}) : super(key: key);

  @override
  State<CalendarMonthView> createState() => _CalendarMonthViewState();
}

class _CalendarMonthViewState extends State<CalendarMonthView> {
   DateTime selectedMonth = DateTime.now().monthStart;
   DateTime selectedDate = DateTime.now().dayStart;
  @override
  void initState() {
    selectedMonth = DateTime.now().monthStart;
    selectedMonth = DateTime.now().dayStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.42,
      padding : const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _Header(
            selectedMonth: selectedMonth,
            selectedDate: selectedDate,
            onChange: (value) => setState(() => selectedMonth = value),
          ),
          Expanded(
            child: _Body(
              selectedDate: selectedDate,
              selectedMonth: selectedMonth,
              selectDate: (DateTime value) => setState(() {
                selectedDate = value;
                widget.onTap.call(selectedDate);
              }),
              selectedColor: widget.selectedColor,
            ),
          ),
          // _Bottom(
          //   selectedDate: selectedDate,
          // )
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
     required this.selectedMonth,
     required this.selectedDate,
     required this.selectDate,
     required this.selectedColor,
  });

  final DateTime selectedMonth;
  final DateTime selectedDate;
  final Color selectedColor;

  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('MON', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            Text('TUS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('WED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('THU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('FRI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('SAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('SUN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1,
              color: Colors.black26,
              margin: const EdgeInsets.only(left: 5, right: 5),
            ),
            for (var week in data.weeks)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: week.map((d) {
                  return _RowItem(
                    hasRightBorder: false,
                    date: d.date,
                    isActiveMonth: d.isActiveMonth,
                    onTap: () => selectDate(d.date),
                    isSelected: selectedDate.isSameDate(d.date),
                    selectedColor: selectedColor,
                  );
                }).toList(),
              ),
          ],
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
     required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
    required this.selectedColor,
  });

  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;
  final Color selectedColor;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;
    final bool isPassed = date.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 35,
            width: 35,
            decoration: isSelected
                ?  BoxDecoration(color: selectedColor, shape: BoxShape.circle)
                //: isToday
                //? BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: AppColors.kPrimary,),)
                : null,
            child: Text(
              number.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: isPassed ? isActiveMonth ? isSelected? Colors.white : Colors.grey : Colors.transparent : isActiveMonth ? isSelected? Colors.white : Colors.black : Colors.grey[300]
              ),
            ),
          ),
          if(isToday)
          Positioned(
            bottom: 3,
            right: 0,
            left: 0,
            child: Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
     required this.selectedMonth,
     required this.selectedDate,
     required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Text('Selected date: ${selectedDate == null ? 'non' : "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}"}'),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(-1));
                },
                icon: const Icon(Icons.keyboard_arrow_left, size: 30, color: Colors.black26,),
              ),
              Expanded(
                child: Text(
                  // 'Month: ${selectedMonth.month + 1}/${selectedMonth.year} ${DateFormat.MMMM().format(selectedMonth).toUpperCase()}',
                  DateFormat.MMMM().format(selectedMonth).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight:FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(1));
                },
                icon: const Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black26),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _Bottom extends StatelessWidget {
  const _Bottom({
     required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            //print(selectedDate);
          },
          child: const Text('save'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('cancel'),
        ),
      ],
    );
  }
}

class CalendarMonthData {
  final int year;
  final int month;

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);
  int get firstDayOfWeekIndex => 0;

  int get weeksCount => ((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
     required this.year,
     required this.month,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    return (weekdayFromMonday - ((firstDayOfWeekIndex - 1) % 7)) % 7 - 1;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
            (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
            isActiveDate: date.isToday,
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;
  final bool isActiveDate;

  const CalendarDayData({
     required this.date,
     required this.isActiveMonth,
     required this.isActiveDate,
  });
}


Color invert(Color color) {
  final r = 255 - color.red;
  final g = 255 - color.green;
  final b = 255 - color.blue;

  return Color.fromARGB((color.opacity * 255).round(), r, g, b);
}