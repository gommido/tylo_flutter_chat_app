import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import 'agora_video_buttons_widget.dart';
import 'agora_video_viewer_widget.dart';

class AgoraVideoCallWidget extends StatelessWidget {
  const AgoraVideoCallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomStack(
      children: const [
        AgoraVideoViewerWidget(),
        AgoraVideoButtonsWidget(),
      ],
    );
  }
}
