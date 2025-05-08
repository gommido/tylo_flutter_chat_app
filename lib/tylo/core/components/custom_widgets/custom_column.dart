import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  CustomColumn({
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
    return Column(
      mainAxisAlignment: mainAxisAlignment != null ? mainAxisAlignment! : MainAxisAlignment.start ,
      crossAxisAlignment: crossAxisAlignment != null ?crossAxisAlignment! : CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize != null ? mainAxisSize! : MainAxisSize.max,
      children: children,
    );
  }
}
