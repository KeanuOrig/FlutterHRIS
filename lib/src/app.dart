import 'package:flutter/material.dart';
import 'package:hris_mobile_app/routes.dart';
import 'package:hris_mobile_app/src/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRIS App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      routes: Routes.getRoutes(),
    );
  }
}
