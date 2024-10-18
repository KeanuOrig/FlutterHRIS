import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget page;
  final int previousIndex;
  final int currentIndex;

  CustomPageTransition({
    required this.page,
    required this.previousIndex,
    required this.currentIndex,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;
      Offset end;
      Curve curve;

      if (currentIndex > previousIndex) {
        // If moving to the right, slide from left to right
        begin = const Offset(-1.0, 0.0);
        end = Offset.zero;
      } else {
        // If moving to the left, slide from right to left
        begin = const Offset(1.0, 0.0);
        end = Offset.zero;
      }

      curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
