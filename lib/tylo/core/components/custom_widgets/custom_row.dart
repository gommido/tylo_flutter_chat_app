import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  CustomRow({
    super.key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    required this.children
  });
  MainAxisAlignment? mainAxisAlignment;
  CrossAxisAlignment? crossAxisAlignment;
  MainAxisSize? mainAxisSize;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment != null ? mainAxisAlignment! : MainAxisAlignment.start ,
      crossAxisAlignment: crossAxisAlignment != null ?crossAxisAlignment! : CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize != null ? mainAxisSize! : MainAxisSize.max,
      children: children,
    );
  }
}
