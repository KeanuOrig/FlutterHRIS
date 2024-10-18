import 'package:flutter/material.dart';
import 'package:hris_mobile_app/src/components/navbar.dart';
import 'package:hris_mobile_app/src/views/home_page.dart';
import 'package:hris_mobile_app/src/views/attendance_page.dart';
import 'package:hris_mobile_app/src/views/leave_page.dart';
import 'package:hris_mobile_app/src/views/user_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final String title;

  static const String homeRoute = '/home';
  static const String attendanceRoute = '/attendance';
  static const String leaveRoute = '/leave';
  static const String userRoute = '/user';

  const BasePage({
    super.key,
    required this.child,
    required this.currentRoute,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    final List<NavItem> navItems = [
      NavItem(title: 'Dashboard', route: homeRoute, icon: Icons.dashboard, page: const HomePage()),
      NavItem(title: 'Attendance', route: attendanceRoute, icon: Icons.event, page: const AttendancePage()),
      NavItem(title: 'Leave', route: leaveRoute, icon: Icons.beach_access, page: const LeavePage()),
      NavItem(title: 'Profile', route: userRoute, icon: Icons.person, page: const UserPage()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: child,
      bottomNavigationBar: Navbar(
        navItems: navItems,
        currentRoute: currentRoute,
      ),
    );
  }
}

// TODO: Implement token check and redirect to the login page if null or if 401