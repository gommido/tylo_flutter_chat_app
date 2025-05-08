import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/font_manager.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../domain/entities/chat_message.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatRoomEmojiMessageWidget extends StatelessWidget {
  const ChatRoomEmojiMessageWidget({super.key, required this.chatMessage});
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2.5,
      width: size.width / 2,
      padding: const EdgeInsets.all(5.0),
      child: CustomText(
        data: chatMessage.messageText == AppStrings.messageDeleted ? translate(context, AppStrings.messageDeleted) : chatMessage.messageText,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: chatMessage.messageText != AppStrings.messageDeleted ? chatMessage.sentBy == context.read<HomeCubit>().id ?
          ColorManager.black : ColorManager.white :
          ColorManager.white,
          decoration: chatMessage.messageText == AppStrings.messageDeleted ?
          TextDecoration.lineThrough : null,
          fontSize: FontManager.s30
        ),
      ),
    );
  }
}
