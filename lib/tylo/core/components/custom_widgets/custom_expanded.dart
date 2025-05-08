import 'package:flutter/material.dart';

class CustomExpanded extends StatelessWidget {
  const CustomExpanded({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: child,
    );
  }
}
