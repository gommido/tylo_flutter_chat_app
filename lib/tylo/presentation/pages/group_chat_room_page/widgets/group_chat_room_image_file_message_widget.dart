import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/image_file_message_widget.dart';
import '../../../../core/components/loading_widget.dart';
import '../../../../core/components/message_side_end_line_widget.dart';
import '../../../../core/components/message_side_start_line_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/group_controller/group_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'group_member_name_widget.dart';

class GroupChatRoomImageFileMessageWidget extends StatelessWidget {
  const GroupChatRoomImageFileMessageWidget({super.key, required this.groupMessage});
  final GroupMessage groupMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
        listener: (context, state){},
        builder: (context, state){
          final size = MediaQuery.of(context).size;
          return CustomRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MessageSideStartLineWidget(
                sentBy: groupMessage.sentBy,
              ),
              CustomExpanded(
                child: CustomRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSizedBox(width: size.width / 50,),
                    CustomExpanded(
                      child: CustomColumn(
                        children: [
                          CustomRow(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomCircleShapeWidget(
                                  width: size.width / 20,
                                  height: size.width / 20,
                                  image: CustomBuilder(
                                    builder: (context){
                                      if(groupMessage.senderImage.isNotEmpty){
                                        return CustomCachedNetworkImageWidget(
                                          width: size.width / 20,
                                          height: size.width / 20,
                                          imageUrl: groupMessage.senderImage,
                                          icon: Icons.person,
                                        );
                                      }
                                      return CustomIcon(icon: Icons.person, color: ColorManager.grey, size: 10,);
                                    },
                                  )
                              ),
                              GroupMemberNameWidget(name: groupMessage.senderName),
                            ],
                          ),
                          CustomSizedBox(height: size.height / 100,),
                          ImageFileMessageWidget(
                            sentBy: groupMessage.sentBy,
                            senderName: groupMessage.senderName,
                            messageText: groupMessage.messageText,
                            imageFile: context.read<FilePickerCubit>().pickedFile?.$1!,
                            messageTime: groupMessage.messageTime,
                            messageId: groupMessage.messageId,
                            isGroupChatPage: true,
                          ),
                        ],
                      ),
                    ),
                    CustomColumn(
                      children: [
                        CustomGestureDetector(
                          onTap: (){
                            //context.read<ChatCubit>().saveNetworkImage(imageUrl: chatMessage.messageText);
                          },
                          child: CustomBuilder(
                            builder: (context) {
                              if(groupMessage.sentBy != context.read<HomeCubit>().id && groupMessage.messageText.isNotEmpty){
                                if(context.watch<ChatCubit>().isImageDownloading != null){
                                  return const LoadingWidget(color: ColorManager.white);
                                }
                                return CustomIcon(
                                  icon: Icons.download,
                                  color: ColorManager.white,
                                );
                              }
                              return CustomSizedBox();
                            }
                          ),
                        ),
                        CustomSizedBox(height: size.height / 50,),
                        CustomBuilder(
                          builder: (context){
                            if(groupMessage.sentBy !=context.read<HomeCubit>().id){
                              if(context.watch<ChatCubit>().isImageDownloading != null){
                                return  CustomContainer(
                                  width: groupMessage.sentBy == context.read<HomeCubit>().id?
                                  size.width / 3 : size.width / 9,
                                  height: size.width / 200,
                                  child: const LinearProgressIndicator(
                                    backgroundColor: ColorManager.transparent,
                                    color: ColorManager.green,
                                  ),
                                );
                              }
                            }

                            return MessageSideEndLineWidget(
                              sentBy: groupMessage.sentBy,
                            );
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          );
        },
    );
  }
}
