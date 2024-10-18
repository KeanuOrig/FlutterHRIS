import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/models/attendance.dart';
import 'package:hris_mobile_app/src/repositories/attendance_repository.dart';
import 'package:hris_mobile_app/src/utils/attendance_utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final AttendanceRepository attendanceRepository = AttendanceRepository();
  
  CalendarBloc() : super(CalendarInitial()) {
    on<LoadCalendar>(_onLoadCalendar);
  }

  Future<void> _onLoadCalendar(LoadCalendar event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      var user = jsonDecode(prefs.getString('user')!);

      int branchId = user['branchId'];
      int departmentId = user['departmentId']; 
      int userId = user['id'];
      String firstDay = DateFormat('yyyy-MM-dd').format(DateTime(event.date.year, event.date.month, 1));
      String lastDay = DateFormat('yyyy-MM-dd').format(DateTime(event.date.year, event.date.month + 1, 0));

      final userAttendances = await attendanceRepository.getUserAttendance(
        startDate: firstDay, 
        endDate: lastDay, 
        branchId: branchId, 
        departmentId: departmentId
      ); 

      final attendances = AttendanceUtils.filterUserAttendance(userAttendances, userId);
      final filteredAttendances = _filterAttendance(attendances);
      
      Map<DateTime, List<dynamic>?> events = {};
      // todo : add other events here like leaves holiday etc.
      for (var attendance in filteredAttendances) {
        var attendanceDate = DateFormat("yyyy-MM-dd").parse(attendance.date);
        if (events[attendanceDate] == null) {
          events[attendanceDate] = [];
        }
        events[attendanceDate]!.add({
          'timeIn': attendance.timeIn,
          'timeOut': attendance.timeOut,
          'location': attendance.location,
        });
      }
      emit(CalendarLoaded(attendances: filteredAttendances, events: events));
    } catch (e) {
      emit(CalendarFailure(e.toString()));
    }
  }

  // Cases when there are multiple time ins
  List<Attendance> _filterAttendance(List<Attendance> attendances) {
    Map<DateTime, Attendance> filteredMap = {};

    for (var attendance in attendances) {
      DateTime date = DateFormat("yyyy-MM-dd").parse(attendance.date);

      // Check if a record for this date already exists
      if (filteredMap.containsKey(date)) {
        // If the existing record already has a timeOut or if the new attendance record does not have a timeOut, skip it
        if (filteredMap[date]!.timeOut != null || attendance.timeOut == null) {
          continue;
        }
        // Replace the existing record with the new attendance record
        filteredMap[date] = attendance;
      } else {
        // If there is no record for this date, add it to the map
        filteredMap[date] = attendance;
      }
    }

    // Convert the map values back to a list
    List<Attendance> filteredList = filteredMap.values.toList();

    filteredList.sort((a, b) => a.date.compareTo(b.date));
    
    return filteredList;
  }
}
