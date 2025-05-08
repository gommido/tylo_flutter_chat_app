import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_icon.dart';

class ArrowBackIcon extends StatelessWidget {
  const ArrowBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      icon: Icons.arrow_back,
      color: ColorManager.white,
    );
  }
}
