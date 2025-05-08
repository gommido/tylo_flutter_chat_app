import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/chat_room_video_message_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/file_message_bottom_time_sent_widget.dart';
import '../../../../core/components/message_side_end_line_widget.dart';
import '../../../../core/components/message_side_start_line_widget.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class ChatRoomVideoUrlMessageWidget extends StatelessWidget {
  const ChatRoomVideoUrlMessageWidget({super.key, required this.chatMessage, required this.index});
  final ChatMessage chatMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomRow(
          children: [
            MessageSideStartLineWidget(
              sentBy: chatMessage.sentBy,
            ),
            CustomExpanded(
              child: CustomStack(
                alignment: Alignment.center,
                children: [
                  ChatRoomVideoMessageWidget(
                    chatMessage: chatMessage,
                    index: index,
                  ),
                  CustomBuilder(
                    builder: (context){
                      if(chatMessage.messageText != AppStrings.messageDeleted){
                        return FileMessageBottomTimeSentWidget(
                          sentBy: chatMessage.sentBy,
                          messageTime: chatMessage.messageTime,
                          isSeen: chatMessage.isSeen,
                        );
                      }
                      return CustomSizedBox();
                    },
                  ),
                ],
              ),
            ),
            MessageSideEndLineWidget(
              sentBy: chatMessage.sentBy,
            )
          ],
        );
      },
    );
  }
}
