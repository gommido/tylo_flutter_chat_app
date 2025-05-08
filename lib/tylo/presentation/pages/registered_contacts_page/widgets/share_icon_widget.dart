import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';

class ShareIconWidget extends StatelessWidget {
  const ShareIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCircleAvatar(
      radius: 20,
      backgroundColor: ColorManager.primaryColor.withOpacity(0.1),
      child:  CustomIcon(icon: Icons.share, color: ColorManager.white,
      ),
    );
  }
}
