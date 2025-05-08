import 'package:flutter/material.dart';

import '../../../../core/components/image_message_screen_fitted_widget.dart';

class GroupChatRoomImageMessageScreenFittedWidget extends StatelessWidget {
  const GroupChatRoomImageMessageScreenFittedWidget({super.key, required this.senderName});
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return ImageMessageScreenFittedWidget(
      senderName: senderName,
    );
  }
}
