import 'package:flutter/material.dart';

/*
PageRouteBuilder navigateFadeAnimation(RouteSettings settings, Widget widget){
  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) =>  widget,
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
  );
}

 */


PageRouteBuilder navigateFadeAnimation(RouteSettings settings, Widget widget){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

