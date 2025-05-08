import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../chat_home_page/widgets/last_message_audio_type_widget.dart';
import '../../chat_home_page/widgets/last_message_image_type_widget.dart';
import '../../chat_home_page/widgets/last_message_type_icon_widget.dart';
import '../../chat_home_page/widgets/last_message_video_type_widget.dart';
import '../../chat_home_page/widgets/last_message_voice_note_type_widget.dart';
import 'group_last_message_owner_name_widget.dart';
import 'groups_home_page_last_message_text_widget.dart';

class GroupsHomePageLastMessageTitleWidget extends StatelessWidget {
  const GroupsHomePageLastMessageTitleWidget({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    return CustomExpanded(
      child: CustomRow(
        children: [
          GroupLastMessageOwnerNameWidget(
            id: group.lastMessageSenderId,
            lastMessageSenderName: group.lastMessageSenderName,
          ),
          LastMessageTypeIconWidget(
            messageType: group.lastMessageType,
          ),
          CustomBuilder(
            builder: (context){
              switch(group.lastMessageType){
                case AppStrings.text:
                  return GroupsHomePageLastMessageTextWidget(
                    group: group,
                  );
                case AppStrings.image:
                  return const LastMessageImageTypeWidget();
                case AppStrings.video:
                  return const LastMessageVideoTypeWidget();
                case AppStrings.voiceNote:
                  return const LastMessageVoiceNoteTypeWidget();
                case AppStrings.audio:
                  return const LastMessageAudioTypeWidget();
              }
              return CustomSizedBox();
            },
          ),
        ],
      ),
    );

  }
}
