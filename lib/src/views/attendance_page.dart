import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/blocs/attendance/attendance_bloc.dart';
import 'package:hris_mobile_app/src/blocs/attendance/attendance_event.dart';
import 'package:hris_mobile_app/src/blocs/attendance/attendance_state.dart';
import 'package:hris_mobile_app/src/blocs/calendar/calendar_bloc.dart';
import 'package:hris_mobile_app/src/blocs/calendar/calendar_event.dart';
import 'package:hris_mobile_app/src/blocs/calendar/calendar_state.dart';
import 'package:hris_mobile_app/src/components/default_calendar.dart';
import 'package:hris_mobile_app/src/components/loading_screen.dart';
import 'package:hris_mobile_app/src/components/custom_snackbar.dart';
import 'package:intl/intl.dart';
import 'base_page.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  AttendancePageState createState() => AttendancePageState();
}


class AttendancePageState extends State<AttendancePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late List<dynamic> _event = [];

  Stream<String> getCurrentTime() async* {
  
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateFormat('HH:mm:ss').format(DateTime.now());
    }
  } 

  List<dynamic> _getEventSelectedDay(DateTime selectedDay, Map<DateTime, List<dynamic>?> events) {
    for (var date in events.keys) {
      if (
        date.year == selectedDay.year &&
        date.month == selectedDay.month &&
        date.day == selectedDay.day
      ) {
        return events[date]!;
      } 
    }
    return [];
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AttendanceBloc()..add(LoadAttendance())),
        BlocProvider(create: (context) => CalendarBloc()..add(LoadCalendar(date: DateTime.now()))),
      ],
      child: BasePage(
        currentRoute: '/attendance',
        title: 'Attendance',
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildCurrentTimeWidget(),
              const SizedBox(height: 10),
              _buildAttendanceBlocConsumer(),
              const SizedBox(height: 40),
              _buildCalendarBlocBuilder(),
              const SizedBox(height: 10.0),
              _buildEventList(),
            ],  
          ),
        ),
      )
    );
  }

  Widget _buildCurrentTimeWidget() {
    return StreamBuilder<String>(
      stream: getCurrentTime(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }

  Widget _buildAttendanceBlocConsumer() {
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceTimedIn) {
          CustomSnackBar.show(
            context,
            text: 'Success Time In!',
            backgroundColor: Colors.green,
          );
        } 
        
        if (state is AttendanceTimedOut) {
          CustomSnackBar.show(
            context,
            text: 'Success Time Out!',
            backgroundColor: Colors.green,
          );
        }

        if (state is AttendanceFailure) {
          CustomSnackBar.show(
            context,
            text: state.message,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is AttendanceInitial) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
            ),
            onPressed: () {},
            child: const Text('Loading...'),
          );
        } else if (state is AttendanceLoading) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
            ),
            onPressed: () {},
            child: const Text('Loading...'),
          );
        } else if (state is AttendanceTimedIn || state is AttendanceTimedOut) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<AttendanceBloc>().add(TimeOut());
              context.read<CalendarBloc>().add(LoadCalendar(date: DateTime.now()));
              setState(() {
                _selectedDay = DateTime.now();
              });
            },
            child: const Text('Time Out'),
          );
        } else if (state is AttendanceLoaded) {
          final bool hasTimeIn = state.hasTimeIn;

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: hasTimeIn ? Colors.red : Colors.green,
            ),
            onPressed: () {
              context.read<AttendanceBloc>().add(hasTimeIn ? TimeOut() : TimeIn());
              context.read<CalendarBloc>().add(LoadCalendar(date: DateTime.now()));
              setState(() {
                _selectedDay = DateTime.now();
              });
            },
            child: Text(hasTimeIn ? 'Time Out' : 'Time In'),
          );
        } else if (state is AttendanceFailure) {
          return const Center(child: Text('Error occurred'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _buildCalendarBlocBuilder() {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        if (state is CalendarLoaded) {
          setState(() {
            _event = _getEventSelectedDay(DateTime.now(), state.events);
          });
        }
      },
      builder: (context, state) {
        if (state is CalendarLoaded) {
          return TableCalendar(
            // Customize the calendar
            firstDay: DateTime(DateTime.now().year - 1, 1, 1),
            lastDay: DateTime(DateTime.now().year + 1, 12, 31),
            focusedDay: _focusedDay,

            // Configure appearance
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
            selectedDayPredicate: (day) =>isSameDay(day, _selectedDay),
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              
              context.read<CalendarBloc>().add(LoadCalendar(date: focusedDay));
            },
            // Event handling
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _event = _getEventSelectedDay(selectedDay, state.events);
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                // Retrieve attendances for the current date
                var attendances = state.attendances;
                
                // Filter attendances for the current date
                attendances = attendances.where((attendance) {
                  var attendanceDate = DateFormat("yyyy-MM-dd").parse(attendance.date);
                  return attendanceDate.year == date.year &&
                    attendanceDate.month == date.month &&
                    attendanceDate.day == date.day;
                }).toList();
                
                // Determine marker colors based on attendances
                bool hasTimeIn = attendances.any((attendance) => attendance.timeIn != null);
                bool hasTimeOut = attendances.any((attendance) => attendance.timeOut != null);

                // Build markers based on conditions
                if (hasTimeIn && hasTimeOut) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                } else if (hasTimeIn) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        } else {
          return DefaultCalendar(focusedDay: _focusedDay);
        }
      }
    );
  }

  Widget _buildEventList() {
  if (_event.isEmpty) {
    return _buildDefaultTimeCards();
  } 
  
  return Expanded(
    child: ListView.builder(
      itemCount: _event.length,
      itemBuilder: (context, index) {

        var locationEvent = _event[index]['location'];
        var location = '';

        switch (locationEvent) {
          case 1:
            location = ' (WFH)';
          case 2:
            location = ' (Office)';
          default:
            location = '';
        }
        
        var timeIn = _event[index]['timeIn'];
        var timeOut = _event[index]['timeOut'] ?? '';

        if (!timeIn.isEmpty && timeOut.isEmpty) {
          timeOut = '-';
          return _buildTimeCards(timeIn + location, timeOut);
        } 

        if (!timeIn.isEmpty && !timeOut.isEmpty) {
          return _buildTimeCards(timeIn + location, timeOut + location);
        } 
          
        return _buildTimeCards(timeIn, timeOut);
      },
    ),
  );
}

  // Method to build the default time cards
  Widget _buildDefaultTimeCards() {
    return Column(
      children: [
        _buildTimeCard('Time In: -', 'assets/images/time-in.png'),
        _buildTimeCard('Time Out: -', 'assets/images/time-out.png'),
      ],
    );
  }

  // Method to build time cards for each event
  Widget _buildTimeCards(String timeIn, String timeOut) {
    return Column(
      children: [
        _buildTimeCard('Time In: $timeIn', 'assets/images/time-in.png'),
        _buildTimeCard('Time Out: $timeOut', 'assets/images/time-out.png'),
      ],
    );
  }

  // Method to build a single time card
  Widget _buildTimeCard(String title, String imagePath) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 25,
          height: 25,
        ),
        title: Text(title),
      ),
    );
  }
}


