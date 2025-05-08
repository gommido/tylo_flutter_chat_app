import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';
import 'loading_widget.dart';

class WaitingLoadingWidget extends StatelessWidget {
  const WaitingLoadingWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      width: size.width / 1.5,
      height: size.height / 10,
      decoration: BoxDecoration(
        color: ColorManager.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoadingWidget(color: ColorManager.white,),
          CustomSizedBox(width: size.width / 50,),
          CustomText(
            data: text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorManager.white,
            ),
          )
        ],
      ),
    );
  }
}
