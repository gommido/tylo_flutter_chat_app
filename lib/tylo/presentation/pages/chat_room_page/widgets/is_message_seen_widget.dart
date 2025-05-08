import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';

class IsMessageSeenWidget extends StatelessWidget {
  const IsMessageSeenWidget({super.key, required this.isSeen,});
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCircleAvatar(
      radius: size.width / 50,
      backgroundColor: isSeen ? ColorManager.green : ColorManager.black,
      child: CustomIcon(
        icon: Icons.done_all,
        size: size.width / 30,
        color: isSeen ? Colors.white : Colors.white,
      ),
    );
  }
}
