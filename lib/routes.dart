import 'package:flutter/material.dart';
import 'package:hris_mobile_app/src/views/attendance_page.dart';
import 'src/views/login_page.dart';
import 'src/views/home_page.dart';
import 'src/views/leave_page.dart';
import 'src/views/user_page.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String leave = '/leave';
  static const String user = '/user';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const HomePage(),
      attendance: (context) => const AttendancePage(),
      leave: (context) => const LeavePage(),
      user: (context) => const UserPage(),
    };
  }
}