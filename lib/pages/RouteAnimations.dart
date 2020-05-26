import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteAnimations {
  static Route createRoute(Widget toWhere) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => toWhere,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
