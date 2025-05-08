import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  CustomGestureDetector({super.key,  this.onTap, required this.child, this.onLongPress, this.onPanUpdate, this.onVerticalDragUpdate, this.onVerticalDragEnd});
  VoidCallback? onTap;
  VoidCallback? onLongPress;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final Widget child;
  final void Function(DragUpdateDetails)? onVerticalDragUpdate;
  final void Function(DragEndDetails)? onVerticalDragEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      onLongPress: onLongPress,
      onVerticalDragEnd: onVerticalDragEnd,
      onTap: onTap,
      onPanUpdate: onPanUpdate,
      child: child,
    );
  }
}
