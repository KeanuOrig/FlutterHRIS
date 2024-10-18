import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_mobile_app/src/blocs/leave/leave_bloc.dart';
import 'package:hris_mobile_app/src/components/custom_text_field.dart';
import 'package:hris_mobile_app/src/components/default_calendar.dart';
import 'package:hris_mobile_app/src/components/sun_moon_toggle_component.dart';
import 'base_page.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});
  
  @override
  Widget build(BuildContext context) {
     return BasePage(
      currentRoute: '/leave',
      title: 'Leave',
      child: Center(
        child: Column(
          children: [
            DefaultCalendar(focusedDay: DateTime.now()),
            ElevatedButton(
              child: const Text('Add Leave'),
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  barrierColor: Colors.blue,
                  context: context,
                  isScrollControlled: true, // Allows the bottom sheet to expand with content
                  builder: (BuildContext context) {
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text(
                          'Leave Form',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        centerTitle: true,
                        ),
                        body: const LeaveForm()
                    );
                  },
                );
              },
            ),
          ]
        )
      ),
    );
  }
}

class LeaveForm extends StatelessWidget {
  const LeaveForm({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveBloc = context.read<LeaveBloc>();

    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: <Widget>[
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: state.leaveType,
                decoration: InputDecoration(
                  labelText: 'Leave Type',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) => leaveBloc.add(LeaveTypeChanged(value!)),
                items: <String>['Annual', 'Sick', 'Casual', 'Unpaid']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              _buildCalendarDateRange(context, state, leaveBloc),
              const SizedBox(height: 20),
              const CustomTextField(labelText: 'Reason for Leave', maxLines: 3),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: 'Client',
                decoration: InputDecoration(
                  labelText: 'Approved By',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {},
                items: <String>['Client']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Half Day'),
                value: state.isHalfDay,
                onChanged: (value) => leaveBloc.add(HalfDayToggled(value)),
              ),
              if (state.isHalfDay)
                SunMoonSwitchTile(
                  isAfternoon: state.isAfternoon,
                  onChanged: (value) => leaveBloc.add(AfternoonToggled(value)),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  leaveBloc.add(SubmitLeaveForm());
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendarDateRange(BuildContext context, LeaveState state, LeaveBloc leaveBloc) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      color: Colors.white,
      shadowColor: Colors.black,
      child: ListTile(
        iconColor: Colors.blue,
        title: Text(
          state.dateRange == null
              ? 'Select Date Range'
              : 'From: ${state.dateRange!.start.toLocal()} To: ${state.dateRange!.end.toLocal()}',
        ),
        trailing: const Icon(Icons.calendar_today),
        onTap: () async {
          DateTimeRange? picked = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != state.dateRange) {
            leaveBloc.add(DateRangeChanged(picked));
          }
        },
      ),
    );
  }
}