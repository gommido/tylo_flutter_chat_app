import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/image_message_screen_fitted_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class ChatRoomImageMessageScreenFittedWidget extends StatelessWidget {
  const ChatRoomImageMessageScreenFittedWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return ImageMessageScreenFittedWidget(
          senderName: context.read<ChatCubit>().currentSenderName,
        );
      },
    );
  }
}
