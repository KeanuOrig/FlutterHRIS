part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LeaveTypeChanged extends LeaveEvent {
  final String leaveType;

  LeaveTypeChanged(this.leaveType);

  @override
  List<Object> get props => [leaveType];
}

class DateRangeChanged extends LeaveEvent {
  final DateTimeRange dateRange;

  DateRangeChanged(this.dateRange);

  @override
  List<Object> get props => [dateRange];
}

class HalfDayToggled extends LeaveEvent {
  final bool isHalfDay;

  HalfDayToggled(this.isHalfDay);

  @override
  List<Object> get props => [isHalfDay];
}

class AfternoonToggled extends LeaveEvent {
  final bool isAfternoon;

  AfternoonToggled(this.isAfternoon);

  @override
  List<Object> get props => [isAfternoon];
}

class SubmitLeaveForm extends LeaveEvent {}