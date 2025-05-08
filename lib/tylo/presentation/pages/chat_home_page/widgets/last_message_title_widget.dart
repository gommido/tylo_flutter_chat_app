import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_expanded.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import 'last_message_audio_type_widget.dart';
import 'last_message_image_type_widget.dart';
import 'last_message_text_type_widget.dart';
import 'last_message_type_icon_widget.dart';
import 'last_message_video_call_type_widget.dart';
import 'last_message_video_type_widget.dart';
import 'last_message_voice_note_type_widget.dart';

class LastMessageTitleWidget extends StatelessWidget {
  const LastMessageTitleWidget({super.key, required this.lastMessage});
  final LastMessage lastMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomRow(
        children: [
          LastMessageTypeIconWidget(
            messageType: lastMessage.messageType,
          ),
          CustomSizedBox(width: size.width / 100),

          CustomBuilder(
            builder: (context){
              switch(lastMessage.messageType){
                case AppStrings.text:
                  return LastMessageTextTypeWidget(
                    lastMessage: lastMessage,
                  );
                case AppStrings.image:
                  return const LastMessageImageTypeWidget();
                case AppStrings.video:
                  return const LastMessageVideoTypeWidget();
                case AppStrings.voiceNote:
                  return const LastMessageVoiceNoteTypeWidget();
                case AppStrings.audio:
                  return const LastMessageAudioTypeWidget();
                case AppStrings.videoCall:
                  return const LastMessageVideoCallTypeWidget();
              }
              return CustomSizedBox();
            },
          ),
        ],
      ),
    );
  }
}
