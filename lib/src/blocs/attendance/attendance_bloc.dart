import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/models/attendance.dart';
import 'package:hris_mobile_app/src/repositories/attendance_repository.dart';
import 'package:hris_mobile_app/src/utils/attendance_utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository attendanceRepository = AttendanceRepository();
  
  AttendanceBloc() : super(AttendanceInitial()) {
    on<LoadAttendance>(_onLoadAttendance);
    on<TimeIn>(_onTimeIn);
    on<TimeOut>(_onTimeOut);
  }

  Future<void> _onLoadAttendance(LoadAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final prefs = await SharedPreferences.getInstance();
      var user = jsonDecode(prefs.getString('user')!);

      int branchId = user['branchId'];
      int departmentId = user['departmentId'];
      int userId = user['id'];

      final userAttendances = await attendanceRepository.getUserAttendance(
        startDate: dateNow, 
        endDate: dateNow, 
        branchId: branchId, 
        departmentId: departmentId
      );  

      final attendances = AttendanceUtils.filterUserAttendance(userAttendances, userId);
      final hasTimeIn = _hasTimeInForToday(attendances);

      emit(AttendanceLoaded(hasTimeIn: hasTimeIn));
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> _onTimeIn(TimeIn event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final response = await attendanceRepository.timeIn();
      final responseData = jsonDecode(response.body);
        
      if (response.statusCode == 200) {
        emit(AttendanceTimedIn());
      } else {
        final message = responseData['error']['message'];
        emit(AttendanceFailure(message));
      }
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> _onTimeOut(TimeOut event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final response = await attendanceRepository.timeOut();
      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        emit(AttendanceTimedOut());
      } else {
        final message = responseData['error']['message'];
        emit(AttendanceFailure(message));
      }
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  bool _hasTimeInForToday(List<Attendance> attendances) {
    final today = DateTime.now().toLocal().toIso8601String().substring(0, 10); // 'YYYY-MM-DD'
    final todayAttendance = attendances.where((a) => a.date == today && a.timeIn != null).toList();
    
    if (todayAttendance.isEmpty) {
      return false;
    }
    todayAttendance.sort((a, b) => a.timeIn!.compareTo(b.timeIn!));
    final earliestTimeIn = todayAttendance.first.timeIn;
    return earliestTimeIn != null;
  }
}
