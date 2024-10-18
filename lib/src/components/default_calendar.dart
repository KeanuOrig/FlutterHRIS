import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DefaultCalendar extends StatelessWidget {
  final DateTime focusedDay;
  const DefaultCalendar({super.key, required this.focusedDay});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
      lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        formatButtonVisible: false, 
        titleCentered: true,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black),
        weekendStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
  