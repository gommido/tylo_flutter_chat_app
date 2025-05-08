import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_icon_button.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class EmojiToggleIcon extends StatelessWidget {
  EmojiToggleIcon({super.key, this.chatRoomBottomFocusNode,this.groupChatRoomBottomFocusNode,});
  FocusNode? chatRoomBottomFocusNode;
  FocusNode? groupChatRoomBottomFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
        builder: (context, state){
          return CustomIconButton(
            onPressed: () {
              context.read<ChatCubit>().toggleEmoji();
              if(chatRoomBottomFocusNode != null){
                if(chatRoomBottomFocusNode!.hasFocus){
                  chatRoomBottomFocusNode!.unfocus();
                }
              }else{
                if(groupChatRoomBottomFocusNode!.hasFocus){
                  groupChatRoomBottomFocusNode!.unfocus();
                }
              }
            },
            icon: context.watch<ChatCubit>().isEmojiShowing ?
            CustomIcon(
                icon: Icons.keyboard_double_arrow_down,
                color: ColorManager.white,
            ) : CustomIcon(
                icon: Icons.emoji_emotions_outlined,
                color: ColorManager.white.withOpacity(0.7),
            )
          );
        },
    );
  }
}
