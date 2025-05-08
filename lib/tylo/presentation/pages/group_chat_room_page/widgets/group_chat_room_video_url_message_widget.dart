import 'package:flutter/material.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/message_side_end_line_widget.dart';
import '../../../../core/components/message_side_start_line_widget.dart';
import 'group_chat_room_video_message_widget.dart';

class GroupChatRoomVideoUrlMessageWidget extends StatelessWidget {
  const GroupChatRoomVideoUrlMessageWidget({super.key, required this.groupMessage, required this.index});
  final GroupMessage groupMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomRow(
          children: [
            MessageSideStartLineWidget(
              sentBy: groupMessage.sentBy,
            ),
            GroupChatRoomVideoMessageWidget(
              groupMessage: groupMessage,
              index: index,
            ),
            MessageSideEndLineWidget(
              sentBy: groupMessage.sentBy,
            )
          ],
        );
      },
    );
  }
}
