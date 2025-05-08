import 'package:flutter/material.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';

import '../../../../core/components/audio_message_widget.dart';

class GroupChatRoomAudioMessageWidget extends StatelessWidget {
  const GroupChatRoomAudioMessageWidget({super.key, required this.groupMessage});
  final GroupMessage groupMessage;

  @override
  Widget build(BuildContext context) {
    return AudioMessageWidget(
      messageText: groupMessage.messageText,
      sentBy: groupMessage.sentBy,
      senderImage: groupMessage.senderImage,
      messageTime: groupMessage.messageTime,
      isSeen: false,
      isMessage: true,
      isGroupChatRoom: true,
      voiceNoteDuration: groupMessage.voiceNoteDuration,
    );
  }
}
