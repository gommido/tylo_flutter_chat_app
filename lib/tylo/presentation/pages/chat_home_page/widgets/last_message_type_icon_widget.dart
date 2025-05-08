import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import 'message_type_icon_widget.dart';

class LastMessageTypeIconWidget extends StatelessWidget {
  const LastMessageTypeIconWidget({super.key, required this.messageType});
  final String messageType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBuilder(
      builder: (context){
        switch(messageType){
          case AppStrings.text: return CustomSizedBox();
          case AppStrings.image:
            return const MessageTypeIconWidget(
              icon: Icons.image,
            );
          case AppStrings.video:
            return const MessageTypeIconWidget(
              icon: Icons.video_collection,
            );
          case AppStrings.voiceNote || AppStrings.audio:
            return CustomIcon(
              icon: Icons.audio_file_rounded,
              color: ColorManager.primaryColor.withOpacity(0.5),
              size: size.width / 20,
            );
          case AppStrings.videoCall:
            return const MessageTypeIconWidget(
              icon: Icons.missed_video_call_outlined,
            );
        }
        return CustomSizedBox();
      },
    );
  }
}
