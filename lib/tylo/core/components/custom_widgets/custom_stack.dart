import 'package:flutter/material.dart';

class CustomStack extends StatelessWidget {
  CustomStack({
    super.key,
    required this.children,
    this.alignment,
    this.clipBehavior,
  });
  AlignmentGeometry? alignment;
  final List<Widget> children;
  Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment != null ? alignment! : AlignmentDirectional.topStart,
      clipBehavior: clipBehavior != null ? clipBehavior! : Clip.hardEdge,
      children: children,
    );
  }
}
