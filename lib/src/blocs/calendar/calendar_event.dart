import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class LoadCalendar extends CalendarEvent {
  final DateTime date;

  const LoadCalendar({required this.date});
}

