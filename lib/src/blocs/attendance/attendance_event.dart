import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendance extends AttendanceEvent {}

class TimeIn extends AttendanceEvent {}

class TimeOut extends AttendanceEvent {}
