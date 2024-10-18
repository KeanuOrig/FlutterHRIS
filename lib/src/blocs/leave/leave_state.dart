part of 'leave_bloc.dart';

class LeaveState extends Equatable {
  final String leaveType;
  final DateTimeRange? dateRange;
  final bool isHalfDay;
  final bool isAfternoon;

  const LeaveState({
    this.leaveType = 'Annual',
    this.dateRange,
    this.isHalfDay = false,
    this.isAfternoon = false,
  });

  LeaveState copyWith({
    String? leaveType,
    DateTimeRange? dateRange,
    bool? isHalfDay,
    bool? isAfternoon,
  }) {
    return LeaveState(
      leaveType: leaveType ?? this.leaveType,
      dateRange: dateRange ?? this.dateRange,
      isHalfDay: isHalfDay ?? this.isHalfDay,
      isAfternoon: isAfternoon ?? this.isAfternoon,
    );
  }

  @override
  List<Object?> get props => [
    leaveType, dateRange, isHalfDay, isAfternoon
  ];
}