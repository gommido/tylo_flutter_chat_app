import 'package:flutter/material.dart';

class CustomAlignWidget extends StatelessWidget {
  const CustomAlignWidget({super.key, required this.alignment, required this.child});
  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: child,
    );
  }
}
