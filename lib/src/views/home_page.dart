import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_page.dart';

class HomePage extends StatefulWidget  {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();

  Widget build(BuildContext context) {
    return const BasePage(
      currentRoute: '/home',
      title: 'Dashboard',
      child: Center(
        child: DashboardPlaceholder(firstName: 'firstName', lastName: 'lastName'),
      ),
    );
  }
}

class HomePageState extends State<HomePage> {
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    var user = jsonDecode(prefs.getString('user')!);

    setState(() {
      firstName = user['firstName'] ?? '';
      lastName = user['lastName'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/home',
      title: 'Dashboard',
      child: Center(
        child: DashboardPlaceholder(firstName: firstName, lastName: lastName),
      ),
    );
  }
}

class DashboardPlaceholder extends StatelessWidget {
  final String firstName;
  final String lastName;

  const DashboardPlaceholder({
    super.key, 
    required this.firstName, 
    required this.lastName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
            'assets/images/giphy.gif', // Replace with your planet image asset
            width: 200,
            height: 200,
          ),
        const SizedBox(height: 20),
        const Text(
          'Welcome!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          '$firstName $lastName',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/user');
          },
          child: const Text('View Details'),
        ),
      ],
    );
  }
}
