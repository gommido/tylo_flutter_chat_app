import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../chat_room_page/widgets/date_header_widget.dart';
import 'group_chat_room_message_widget.dart';

class GroupChatRoomMessagesListWidget extends StatefulWidget {
  const GroupChatRoomMessagesListWidget({super.key});

  @override
  State<GroupChatRoomMessagesListWidget> createState() => _GroupChatRoomMessagesListWidgetState();
}

class _GroupChatRoomMessagesListWidgetState extends State<GroupChatRoomMessagesListWidget> {
  late ChatCubit _chatCubit;


  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context, listen:  false);
    _chatCubit.initScrollController();
    if(_chatCubit.isEmojiShowing){
      _chatCubit.toggleEmoji();
    }
  }

  @override
  void dispose() {
    _chatCubit.disposeScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){
        if(state is GetGroupMessagesSuccessState){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<ChatCubit>().scrollToBottom();
          });
        }
      },
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomListViewWidget(
          controller: _chatCubit.scrollController,
          itemCount: context.read<GroupCubit>().groupMessages.length,
          itemBuilder: (context, index){
            final groupMessage = context.read<GroupCubit>().groupMessages[index];
            DateTime currentDateTime = groupMessage.messageTime.toDate();
            bool showDateHeader = true;
            if (index > 0) {
              GroupMessage previousMessage = context.read<GroupCubit>().groupMessages[index - 1];
              DateTime previousDateTime = previousMessage.messageTime.toDate();
              if (DateFormat(AppStrings.datePattern).format(previousDateTime) == DateFormat(AppStrings.datePattern).format(currentDateTime)) {
                showDateHeader = false;
              }
            }
            return CustomColumn(
              children: [
                DateHeaderWidget(
                  showDateHeader: showDateHeader,
                  messageTime: groupMessage.messageTime,
                ),
                CustomSizedBox(height: size.height / 30,),
                GroupChatRoomMessageWidget(groupMessage: groupMessage, index: index,),
                CustomSizedBox(height: size.height / 100,),

              ],
            );
          },
          separatorBuilder: (context, index) => CustomSizedBox(height: size.height / 100,),
        );

      },
    );
  }
}
