import 'package:flutter/material.dart';

class CustomCenter extends StatelessWidget {
  const CustomCenter({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}
