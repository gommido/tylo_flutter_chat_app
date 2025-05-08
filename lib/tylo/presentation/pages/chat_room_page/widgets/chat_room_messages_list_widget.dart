import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import 'chat_room_message_widget.dart';
import 'date_header_widget.dart';

class ChatRoomMessagesListWidget extends StatefulWidget {
  const ChatRoomMessagesListWidget({super.key,});

  @override
  State<ChatRoomMessagesListWidget> createState() => _ChatRoomMessagesListWidgetState();
}

class _ChatRoomMessagesListWidgetState extends State<ChatRoomMessagesListWidget> {
  late ChatCubit _chatCubit;


  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context, listen:  false);
    _chatCubit.initScrollController();
    if(_chatCubit.isEmojiShowing){
      _chatCubit.toggleEmoji();
    }
    _chatCubit.scrollController.addListener(_chatCubit.checkIfUserIsInBottom);
  }

  @override
  void dispose() {
    _chatCubit.disposeScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state){
        if(state is GetChatMessagesSuccessState && context.read<ChatCubit>().isUserAtBottom != null && _chatCubit.isUserAtBottom!){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _chatCubit.scrollToBottom();
          });
        }

      },
      builder: (context, state){
        final size = MediaQuery.of(context).size;

        return CustomListViewWidget(
          controller: _chatCubit.scrollController,
          itemCount: _chatCubit.chatMessages.length,
          itemBuilder: (context, index){
            final message =_chatCubit.chatMessages[index];
            DateTime currentDateTime = message.messageTime.toDate(); // Convert Timestamp to DateTime
            bool showDateHeader = true;
            if (index > 0) {
              ChatMessage previousMessage = _chatCubit.chatMessages[index - 1];
              DateTime previousDateTime = previousMessage.messageTime.toDate();
              if (DateFormat(AppStrings.datePattern).format(previousDateTime) ==
                  DateFormat(AppStrings.datePattern).format(currentDateTime)) {
                showDateHeader = false;
              }
            }
            return CustomColumn(
              children: [

                CustomSizedBox(height: size.height / 50,),
                DateHeaderWidget(showDateHeader: showDateHeader, messageTime: message.messageTime,),
                CustomSizedBox(height: size.height / 50,),
                ChatRoomMessageWidget(message: message, index: index),
                CustomSizedBox(height: size.height / 100,),
              ],
            );
          },
          separatorBuilder: (context, index) => CustomSizedBox(),
        );
      },
    );
  }
}
