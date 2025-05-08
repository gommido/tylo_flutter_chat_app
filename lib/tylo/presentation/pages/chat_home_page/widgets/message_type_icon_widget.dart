import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';

class MessageTypeIconWidget extends StatelessWidget {
  const MessageTypeIconWidget({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomIcon(
      icon: icon,
      color: ColorManager.primaryColor.withOpacity(0.5),
      size: size.width / 20,
    );
  }
}
