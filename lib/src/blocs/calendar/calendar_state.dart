import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List attendances;
  final Map<DateTime, List<dynamic>?> events;
  const CalendarLoaded({required this.attendances, required this.events});
}

class CalendarFailure extends CalendarState {
  final String message;

  const CalendarFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//Todo: copyWith