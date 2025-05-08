import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../chat_room_page/widgets/bottom_speed_dial_widget.dart';
import '../../chat_room_page/widgets/cancel_voice_note_icon_widget.dart';
import '../../chat_room_page/widgets/emoji_picker_widget.dart';
import '../../chat_room_page/widgets/emoji_toggle_icon.dart';
import '../../chat_room_page/widgets/sending_text_widget.dart';
import 'group_chat_room_bottom_message_text_field_widget.dart';
import 'group_chat_room_bottom_send_message_icon_widget.dart';

class GroupChatRoomBottomWidget extends StatefulWidget {
  const GroupChatRoomBottomWidget({super.key,});

  @override
  State<GroupChatRoomBottomWidget> createState() => _GroupChatRoomBottomWidgetState();
}

class _GroupChatRoomBottomWidgetState extends State<GroupChatRoomBottomWidget> {
  late FocusNode _groupChatRoomBottomFocusNode;

  @override
  void initState() {
    super.initState();
    _groupChatRoomBottomFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _groupChatRoomBottomFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.white.withOpacity(0.05),
        ),
      ),
      child: CustomRow(
        children: [
          CustomExpanded(
            child: CustomColumn(
              children: [
                CustomRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmojiToggleIcon(groupChatRoomBottomFocusNode: _groupChatRoomBottomFocusNode,),
                    CustomExpanded(
                      child: GroupChatRoomBottomMessageTextFieldWidget(
                        bottomFocusNode: _groupChatRoomBottomFocusNode,
                        messageController: context.read<GroupCubit>().groupMessageController,
                        isGroupMessage: false,
                      ),
                    ),
                    CustomSizedBox(width: size.width / 100,),
                    BlocConsumerWidget<ChatCubit, ChatState>(
                      listener: (context, state){},
                      builder: (context, state){
                        if(context.read<ChatCubit>().isVoiceIconVisible != null){
                          return const CancelVoiceNoteIconWidget();
                        }
                        if(context.read<GroupCubit>().imageUploadingProgress != null){
                          return const SendingTextWidget();
                        }
                        return const BottomSpeedDialWidget();
                      },
                    ),
                    CustomSizedBox(width: size.width / 100,),
                    GroupChatRoomBottomSendMessageIconWidget(
                        focusNode: _groupChatRoomBottomFocusNode,
                    ),
                    CustomSizedBox(width: size.width / 100,),
                  ],
                ),
                ChatRoomEmojiPickerWidget(controller: context.read<GroupCubit>().groupMessageController,)

              ],
            ),
          ),
        ],
      ),

    );
  }
}
