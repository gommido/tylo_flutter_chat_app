import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';

class CustomInteractionIconWidget extends StatelessWidget {
  const CustomInteractionIconWidget({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: size.width / 2,
      height: size.width / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ColorManager.grey,
        ),
      ),
      child: CustomRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcon(icon: icon, color: ColorManager.green,),
          CustomSizedBox(width: size.width / 50,),
          CustomText(
            data: title,
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ],
      ),
    );
  }
}
