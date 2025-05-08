import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_center.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCenter(
      child: CircularProgressIndicator(
        color: ColorManager.primaryColor,
        backgroundColor: ColorManager.grey,
        strokeWidth: 1,
      ),
    );
  }
}
