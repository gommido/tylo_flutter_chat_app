import 'package:flutter/material.dart';

class CustomBuilder extends StatelessWidget {
  const CustomBuilder({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: builder);
  }
}
