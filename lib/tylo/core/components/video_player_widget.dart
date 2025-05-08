import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_stack.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({super.key, this.controller, this.isPlaying, required this.isScreenFitted});
  CachedVideoPlayerPlusController? controller;
  bool? isPlaying;
  final bool isScreenFitted;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(controller != null){
      return CustomStack(
        alignment: Alignment.center,
        children: [
          CustomBuilder(
            builder: (context){
              if(isScreenFitted){
                return AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CachedVideoPlayerPlus(controller!),
                );
              }
              return CachedVideoPlayerPlus(controller!);
            },
          ),
          CustomBuilder(
              builder: (context) {
                if(isPlaying == null || !isPlaying!){
                  return CustomIcon(
                    icon: Icons.play_circle,
                    color: ColorManager.white.withOpacity(0.5),
                    size: size.height / 20,
                  );
                }
                return CustomSizedBox();
              }
          ),

        ],
      );
    }
    return CustomSizedBox();
  }
}
