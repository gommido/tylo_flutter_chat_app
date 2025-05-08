import 'package:flutter/material.dart';
import 'custom_icon.dart';
import '../../resources/color_manager.dart';

class CustomFloatingActionButtonWidget extends StatelessWidget {
  const CustomFloatingActionButtonWidget({super.key, required this.onPressed, required this.icon});
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: onPressed,
      child: CustomIcon(icon: icon, color: ColorManager.white,),
    );

  }
}
