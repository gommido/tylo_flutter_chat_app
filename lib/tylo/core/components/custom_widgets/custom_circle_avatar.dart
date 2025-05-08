import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, required this.radius, required this.backgroundColor, required this.child, });
  final double radius;
  final Color backgroundColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
