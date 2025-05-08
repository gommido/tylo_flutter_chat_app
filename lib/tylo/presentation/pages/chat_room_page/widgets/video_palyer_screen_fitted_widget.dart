import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/video_controller/video_cubit.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/video_palyer_linear_indicator_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/video_palyer_screen_fitted_back_icon_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../../core/resources/color_manager.dart';
import 'message_video_player_widget.dart';

class VideoPlayerScreenFittedWidget extends StatelessWidget {
  const VideoPlayerScreenFittedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<VideoCubit, VideoState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return SafeArea(
          child: CustomScaffold(
            body: CustomStack(
              children: [
                CustomContainer(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: ColorManager.black.withOpacity(0.5),
                  ),
                  child: CustomGestureDetector(
                    onTap: (){
                      if(!context.read<VideoCubit>().isPlaying){
                        context.read<VideoCubit>().play(fileType: AppStrings.url);
                      }else{
                        context.read<VideoCubit>().onPause(fileType: AppStrings.url);
                      }
                    },
                    child: CustomStack(
                      children: [
                        MessageVideoPlayerWidget(
                          index: context.read<VideoCubit>().currentVideoIndex,
                          isScreenFitted: true,
                        ),
                        CustomPositioned(
                            bottom: 0,
                            child:const VideoPlayerLinearIndicatorWidget()
                        )
                      ],
                    ),
                  ),
                ),
                const VideoPlayerScreenFittedBackIconWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
