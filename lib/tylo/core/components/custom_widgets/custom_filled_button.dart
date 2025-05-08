import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import 'custom_gesture_detector.dart';

class CustomFilledButton extends StatelessWidget {
  CustomFilledButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.width,
    this.height = 50,
    this.isCentered = true,
    this.color = ColorManager.primaryColor,
    this.textColor = ColorManager.white,
    this.borderColor,
    this.fontWeight,
  });
  final VoidCallback onTap;
  final Widget child;
  final double width;
  final double height;
  final bool isCentered;
  final Color color;
  final Color textColor;
  Color? borderColor;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onTap,
      child: Container(
        alignment: isCentered ? AlignmentDirectional.center : AlignmentDirectional.centerStart,
        height: height,
        width: width ,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
            border: Border.all(
              color: borderColor != null ? borderColor! : Colors.transparent,
            )
        ),
        child: child,

      ),
    );
  }
}
