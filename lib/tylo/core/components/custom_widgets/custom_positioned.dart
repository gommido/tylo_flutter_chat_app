import 'package:flutter/cupertino.dart';

class CustomPositioned extends StatelessWidget {
  CustomPositioned({
    super.key,
    this.top,
    this.bottom,
    this.right,
    this.left,
    required this.child});
  double? top;
  double? bottom;
  double? right;
  double? left;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: child,
    );
  }
}
