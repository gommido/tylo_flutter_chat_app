import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class VideoPlayerScreenFittedBackIconWidget extends StatelessWidget {
  const VideoPlayerScreenFittedBackIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPositioned(
      top: 10,
      left: 10,
      child: CustomGestureDetector(
        onTap: (){
          context.read<ChatCubit>().setVideoPlayerScreenFitState();
        },
        child: CustomIcon(
          icon: Icons.arrow_back,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
