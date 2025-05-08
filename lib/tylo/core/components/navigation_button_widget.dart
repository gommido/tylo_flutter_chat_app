import 'package:flutter/material.dart';
import '../services/localization/localization.dart';
import 'custom_widgets/custom_filled_button.dart';
import 'custom_widgets/custom_text.dart';
import '../resources/color_manager.dart';

class NavigationButtonWidget extends StatelessWidget {
  NavigationButtonWidget({super.key, required this.onNavigationState, required this.buttonTitle, this.backColor, this.borderColor});
  final VoidCallback onNavigationState;
  final String buttonTitle;
  Color? backColor;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomFilledButton(
      onTap: onNavigationState,
      width: size.width,
      color: backColor == null ? ColorManager.primaryColor : backColor!,
      borderColor: borderColor == null ? ColorManager.transparent : borderColor!,
      child: CustomText(
        data: translate(context, buttonTitle),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ColorManager.white,
        ),
      ),
    );
  }
}
