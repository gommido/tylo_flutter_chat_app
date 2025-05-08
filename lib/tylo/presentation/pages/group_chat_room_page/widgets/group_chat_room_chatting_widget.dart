import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_body_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_selected_messages_to_delete_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_send_file_message_icon_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_app_bar_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_members_count_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_name_widget.dart';

import '../../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../chat_room_page/widgets/file_message_background_widget.dart';
import '../../chat_room_page/widgets/file_message_viewer_before_sending_widget.dart';
import '../../chat_room_page/widgets/send_voice_note_widget.dart';
import '../../chat_room_page/widgets/unsend_message_file_icon_widget.dart';
import 'group_chat_room_pop_menu_widget.dart';

class GroupChatRoomChattingWidget extends StatelessWidget {
  const GroupChatRoomChattingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
          context: context,
          onPressed: (){
            if(context.read<ChatCubit>().isLongPressed != null){
              context.read<ChatCubit>().clearSelectedItems();
              context.read<ChatCubit>().pressLongTime(isLongPressed: null);
            }else{
              context.read<ChatCubit>().setSendImageIconTapped();
              navigateAndPop(context);
            }
          },
          title: BlocConsumerWidget<ChatCubit, ChatState>(
              listener: (context, state){},
              builder: (context, state){
                return CustomBuilder(
                  builder: (context){
                    if(context.read<ChatCubit>().isLongPressed != null){
                      return const GroupChatRoomSelectedMessagesToDeleteWidget();
                    }
                    if(context.read<GroupCubit>().group != null){
                      return CustomGestureDetector(
                        onTap: (){
                          pushNamed(route: AppRoutes.groupDetailsPage, context: context, arguments: null);
                        },
                        child: CustomRow(
                          children: [
                            const GroupChatRoomAppBarImageWidget(),
                            CustomSizedBox(width: size.width / 50,),
                            CustomColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                GroupNameWidget(),
                                GroupMembersCountWidget(),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return CustomSizedBox();
                  },
                );
              }),
          actions: [
            const GroupChatRoomPopMenuWidget(),
          ]
      ),
      body: CustomStack(
        alignment: Alignment.center,
        children: const [
          // Group Chat Room Body
          GroupChatRoomBodyWidget(),

          // File Message Background
          FileMessageBackgroundWidget(),

          // File Container
          FileMessageViewerBeforeSendingWidget(),

          // Send File Icon
          GroupChatRoomSendFileMessageIconWidget(),

          // UnSend File Icon
          UnSendMessageFileIconWidget(),

          // Send Voice Note Message
          SendVoiceNoteWidget(isGroupChatRoom: true,),

        ],
      ),
    );
  }
}
