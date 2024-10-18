import 'package:hris_mobile_app/src/models/attendance.dart';

// Extract single user attendance from "GetAll" endpoint
class AttendanceUtils {
  static List<Attendance> filterUserAttendance(List userAttendances, int userId) {
    final filteredUserAttendances = userAttendances.where(
      (userAttendance) => userAttendance['information']['user_id'] == userId
    ).toList();

    if (filteredUserAttendances.isNotEmpty) {
      return Attendance.fromJsonList(filteredUserAttendances[0]['attendances']);
    } else {
      return [];
    }
  }
}