import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/sending_text_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import 'bottom_speed_dial_widget.dart';
import 'cancel_voice_note_icon_widget.dart';
import 'chat_room_bottom_message_text_field_widget.dart';
import 'chat_room_bottom_send_message_icon_widget.dart';
import 'emoji_picker_widget.dart';
import 'emoji_toggle_icon.dart';

class ChatRoomBottomWidget extends StatefulWidget {
  const ChatRoomBottomWidget({super.key,});

  @override
  State<ChatRoomBottomWidget> createState() => _ChatRoomBottomWidgetState();
}

class _ChatRoomBottomWidgetState extends State<ChatRoomBottomWidget> {
  late FocusNode _chatRoomBottomFocusNode;

  @override
  void initState() {
    super.initState();
    _chatRoomBottomFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _chatRoomBottomFocusNode.dispose();
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
                    EmojiToggleIcon(chatRoomBottomFocusNode: _chatRoomBottomFocusNode,),
                    CustomExpanded(
                      child: ChatRoomBottomMessageTextFieldWidget(
                        bottomFocusNode: _chatRoomBottomFocusNode,
                        messageController: context.read<ChatCubit>().messageController,
                      ),
                    ),
                    CustomSizedBox(width: size.width / 100,),
                    BlocConsumerWidget<ChatCubit, ChatState>(
                      listener: (context, state){},
                      builder: (context, state){
                        if(context.read<ChatCubit>().isVoiceIconVisible != null){
                          return const CancelVoiceNoteIconWidget();
                        }
                        if(context.read<ChatCubit>().imageUploadingProgress != null){
                          return const SendingTextWidget();
                        }
                        return const BottomSpeedDialWidget();
                      },
                    ),
                    CustomSizedBox(width: size.width / 100,),
                    ChatRoomBottomSendMessageIconWidget(
                        focusNode: _chatRoomBottomFocusNode,
                    ),
                    CustomSizedBox(width: size.width / 100,),
                  ],
                ),
                ChatRoomEmojiPickerWidget(controller: context.read<ChatCubit>().messageController,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
