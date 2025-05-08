import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_container.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';


class CustomCircleShapeWidget extends StatelessWidget {
  CustomCircleShapeWidget({super.key, required this.image, required this.width, required this.height, this.color, this.borderColor});
  final Widget image;
  final double width;
  final double height;
  Color? color;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color == null ? ColorManager.grey.withOpacity(0.5) : color!,
        border: Border.all(
            color: borderColor == null ? ColorManager.white.withOpacity(0.2) : borderColor!,
        ),
        shape: BoxShape.circle,
      ),
      child: image,
    );
  }
}
