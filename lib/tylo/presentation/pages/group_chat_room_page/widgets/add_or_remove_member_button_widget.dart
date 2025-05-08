import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_filled_button.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class AddOrRemoveMemberButtonWidget extends StatelessWidget {
  const AddOrRemoveMemberButtonWidget({super.key, required this.onTap, required this.title});
  final void Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      padding: const EdgeInsets.all(10.0),
      width: size.width,
      height: size.height / 10,
      child: CustomFilledButton(
        onTap: onTap,
        width: size.width,
        color: ColorManager.primaryColor,
        child: CustomText(
          data: title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
