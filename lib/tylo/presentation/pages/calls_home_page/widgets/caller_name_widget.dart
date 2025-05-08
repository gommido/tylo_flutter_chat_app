
import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class CallerNameWidget extends StatelessWidget {
  const CallerNameWidget({super.key, required this.name, required this.isDialed});
  final String name;
  final bool isDialed;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data:  name,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: isDialed ? ColorManager.white : ColorManager.red,
      ),
    );
  }
}
