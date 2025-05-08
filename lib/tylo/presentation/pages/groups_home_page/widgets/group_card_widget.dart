import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_navigator.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'groups_home_page_group_image_widget.dart';
import 'groups_home_page_group_name_widget.dart';
import 'groups_home_page_last_message_title_widget.dart';
import 'groups_home_page_message_time_sent_widget.dart';


class GroupCardWidget extends StatelessWidget {
  const GroupCardWidget({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        if(context.read<ChatCubit>().selectedItems.isEmpty){
          pushNamed(route: AppRoutes.groupChatRoomPage, context: context, arguments: group.id);
        }else{
          if(context.read<ChatCubit>().selectedItems.length == 1 && context.read<ChatCubit>().selectedItems.contains(group.id)){
            context.read<ChatCubit>().clearSelectedItems();
            context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: null);
          }else{
            if(!context.read<ChatCubit>().selectedItems.contains(group.id)){
              context.read<ChatCubit>().selectItems(group.id);
            }else{
              context.read<ChatCubit>().removeFromSelectedItems(group.id);
            }
          }
        }

      },
        onLongPress: (){
          if(context.read<ChatCubit>().selectedItems.isEmpty){
            context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: true,);
            context.read<ChatCubit>().selectItems(group.id);
          }else{
            if(context.read<ChatCubit>().selectedItems.length == 1  && context.read<ChatCubit>().selectedItems.contains(group.id)){
              context.read<ChatCubit>().clearSelectedItems();
              context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: null);
            }else if(!context.read<ChatCubit>().selectedItems.contains(group.id)){
              context.read<ChatCubit>().selectItems(group.id);
            }else{
              context.read<ChatCubit>().removeFromSelectedItems(group.id);
            }
          }
        },
      child: BlocConsumerWidget<ChatCubit, ChatState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomContainer(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            width: size.width,
            height: size.height / 10,
            decoration: BoxDecoration(
              color: context.read<HomeCubit>().isLongPressed != null
                  && context.read<ChatCubit>().selectedItems.contains(group.id) ?
              ColorManager.grey.withOpacity(0.5) : Colors.transparent,
              border: Border.all(
                color: ColorManager.grey.withOpacity(0.05),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: CustomRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomStack(
                  alignment: Alignment.center,
                  children: [
                    GroupsHomePageGroupImageWidget(
                      imageUrl: group.image,
                    ),
                    //const DeletedChatIconWidget(),
                  ],
                ),
                CustomSizedBox(width: size.width / 50),
                CustomExpanded(
                  child: CustomColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GroupsHomePageGroupNameWidget(groupName: group.name,),
                          GroupsHomePageMessageTimeSentWidget(timeSent: group.lastMessageTime,),
                        ],
                      ),
                      CustomSizedBox(height: size.height / 100),
                      GroupsHomePageLastMessageTitleWidget(
                        group: group,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
