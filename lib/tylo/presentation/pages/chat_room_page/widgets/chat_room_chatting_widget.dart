import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/scroll_down_icon_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/send_voice_note_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/unsend_message_file_icon_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'call_icon_widget.dart';
import 'chat_room_app_bar_title_widget.dart';
import 'chat_room_body_widget.dart';
import 'chat_room_pop_menu_widget.dart';
import 'chat_room_selected_messages_to_delete_widget.dart';
import 'chat_room_send_message_file_icon_widget.dart';
import 'file_message_background_widget.dart';
import 'file_message_viewer_before_sending_widget.dart';

class ChatRoomChattingWidget extends StatelessWidget {
  const ChatRoomChattingWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomScaffold(
          appBar: customAppBar(
              context: context,
              onPressed: (){
                if(context.read<ChatCubit>().isLongPressed != null){
                  context.read<ChatCubit>().clearSelectedItems();
                  context.read<ChatCubit>().pressLongTime(isLongPressed: null);
                }else{
                  if(context.read<ChatCubit>().messageController.text.isNotEmpty){
                    context.read<ChatCubit>().updateUserTypingStatus(
                        sentBy: context.read<HomeCubit>().id,
                        isTyping: false,
                    );
                    context.read<ChatCubit>().updateLastMessageTypingStatus(
                      sentBy: context.read<HomeCubit>().id,
                      receiverId: context.read<FireStoreCubit>().streamAppUser!.id,
                      isTyping: false,
                    );
                  }
                  context.read<FireStoreCubit>().updateAppUserData(
                    id: context.read<HomeCubit>().id,
                    field: FireBaseConstants.currentChatRoom,
                    value: '',
                  );
                  context.read<ChatCubit>().clearChatMessages();

                  navigateAndPop(context);
                }
              },
              title: CustomBuilder(
                builder: (context) {
                  if(context.read<ChatCubit>().isLongPressed != null){
                    return const ChatRoomSelectedMessagesToDeleteWidget();
                  }
                  return const ChatRoomAppBarTitleWidget();
                }
              ),
              actions: context.read<ChatCubit>().isLongPressed == null ? [
                const CallIconWidget(),
                const ChatRoomPopMenuWidget()
              ] : null
          ),
          body: CustomStack(
            alignment: Alignment.center,
            children: const [
              // Chat Room Body
              ChatRoomBodyWidget(),

              // File Message Background
              FileMessageBackgroundWidget(),

              // File Container
              FileMessageViewerBeforeSendingWidget(),

              // Send File Icon
              ChatRoomSendMessageFileIconWidget(),

              // UnSend File Icon
              UnSendMessageFileIconWidget(),

              // Send Voice Note Message
              SendVoiceNoteWidget(isGroupChatRoom: false,),

              // Scroll Down Icon
              ScrollDownIconWidget(),
            ],
          ),
        );
      },
    );
  }
}
