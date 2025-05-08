import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_center.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';

class HomePageNoItemsWidget extends StatelessWidget {
  const HomePageNoItemsWidget({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCenter(
      child: CustomColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcon(
            icon: icon,
            color: ColorManager.grey,
          ),
          CustomSizedBox(height: size.height / 50,),
          CustomText(
            data: title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
