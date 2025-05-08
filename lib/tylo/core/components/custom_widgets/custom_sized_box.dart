import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  CustomSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  double? width;
  double? height;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
