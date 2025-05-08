import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider({super.key, required this.color, this.height, this.thickness});
  final Color color;
  double? height;
  double? thickness;


  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
      thickness: thickness,
    );
  }
}
