import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import 'custom_container.dart';
import 'custom_icon.dart';
import 'custom_padding.dart';


SpeedDialChild customSpeedDialChild({
  required IconData icon,
  required Widget label,
  required BuildContext context,
  required VoidCallback onTap,
}){
  return SpeedDialChild(
      onTap: onTap,
      child: CustomIcon(
        icon: icon,
        color: ColorManager.white,
      ),
      labelWidget: CustomContainer(
        decoration: BoxDecoration(
            color:  ColorManager.backgroundColor ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:  ColorManager.white.withOpacity(0.1) ,
            ),
        ),
        child: CustomPadding(
          padding: const EdgeInsets.all(8.0),
          child: label,
        ),
      ),
      backgroundColor: ColorManager.backgroundColor,
      labelBackgroundColor:  ColorManager.primaryColor,
      labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: FontManager.s10,
      ),
  );
}