import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/chat_emoji_picker_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';


class ChatRoomEmojiPickerWidget extends StatelessWidget {
  const ChatRoomEmojiPickerWidget({super.key, required this.controller,});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ChatEmojiPickerWidget(
          offstage: !context.read<ChatCubit>().isEmojiShowing,
          controller: controller,
          onBackspacePressed: (){
            controller
              ..text = controller.text.characters.toString()
              ..selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
          },
        );
      },
);
  }
}
