import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({super.key, required this.padding, required this.child});
  final EdgeInsetsGeometry padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
