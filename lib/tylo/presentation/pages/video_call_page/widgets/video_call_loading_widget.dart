import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/loading_widget.dart';
import '../../../../core/resources/color_manager.dart';

class VideoCallLoadingWidget extends StatelessWidget {
  const VideoCallLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPositioned(
      right: 0, top: 0,
      child: CustomContainer(
        width: size.width / 3,
        height: size.width / 2,
        decoration: const BoxDecoration(
          color: ColorManager.black,
        ),
        child: const LoadingWidget(color: ColorManager.white,),
      ),
    );
  }
}
