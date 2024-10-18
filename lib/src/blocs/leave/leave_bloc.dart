import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(const LeaveState()) {
    on<LeaveTypeChanged>((event, emit) {
      emit(state.copyWith(leaveType: event.leaveType));
    });

    on<DateRangeChanged>((event, emit) {
      emit(state.copyWith(dateRange: event.dateRange));
    });

    on<HalfDayToggled>((event, emit) {
      emit(state.copyWith(isHalfDay: event.isHalfDay));
    });

    on<AfternoonToggled>((event, emit) {
      emit(state.copyWith(isAfternoon: event.isAfternoon));
    });

    on<SubmitLeaveForm>((event, emit) {
      // Handle form submission logic
      print('Leave Type: ${state.leaveType}');
      print('Date Range: ${state.dateRange}');
      print('Half Day: ${state.isHalfDay}');
      print('Afternoon: ${state.isAfternoon}');
    });
  }
}