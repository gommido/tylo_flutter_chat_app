import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import 'custom_widgets/custom_circle_avatar.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_icon_button.dart';

class BottomSendMessageIconWidget extends StatelessWidget {
  const BottomSendMessageIconWidget({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCircleAvatar(
      radius: 18,
      backgroundColor: ColorManager.primaryColor.withOpacity(0.5),
      child: CustomIconButton(
        onPressed: onPressed,
        icon: CustomIcon(
          icon: Icons.arrow_upward,
          size: size.height / 45,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
