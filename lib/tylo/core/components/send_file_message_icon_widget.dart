import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_circle_avatar.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_gesture_detector.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_positioned.dart';
import 'custom_widgets/custom_sized_box.dart';

class SendFileMessageIconWidget extends StatelessWidget {
  const SendFileMessageIconWidget({super.key, required this.visible, this.onTap});
  final bool visible;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(visible){
      return CustomPositioned(
        bottom: 100,
        right: 0,
        child: CustomColumn(
          children: [
            CustomGestureDetector(
              onTap: onTap,
              child: CustomCircleAvatar(
                radius: 20,
                backgroundColor: ColorManager.primaryColor.withOpacity(0.5),
                child: CustomIcon(
                  icon: Icons.arrow_upward_outlined,
                  color: ColorManager.white,

                ),
              ),
            ),
            CustomSizedBox(height: size.height / 100,),
            CustomContainer(
              width: size.width / 200,
              height: size.height / 10,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    }
    return CustomSizedBox();
  }
}
