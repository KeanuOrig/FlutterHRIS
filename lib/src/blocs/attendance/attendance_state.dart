import 'package:equatable/equatable.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final bool hasTimeIn;
  
  const AttendanceLoaded({required this.hasTimeIn});
}

class AttendanceTimedIn extends AttendanceState {}

class AttendanceTimedOut extends AttendanceState {}

class AttendanceFailure extends AttendanceState {
  final String message;

  const AttendanceFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//Todo: copyWith