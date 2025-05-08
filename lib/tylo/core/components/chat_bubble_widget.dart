import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_positioned.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/core/components/message_time_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/is_message_seen_widget.dart';
import '../../presentation/pages/group_chat_room_page/widgets/group_member_name_widget.dart';
import '../resources/color_manager.dart';
import 'custom_cached_network_image_widget.dart';
import 'custom_circle_shape_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';

class ChatBubbleWidget extends StatelessWidget {
  ChatBubbleWidget({
    super.key,
    required this.sentBy,
    required this.messageText,
    required this.messageTime,
    this.isSeen,
    required this.message,
    required this.imageUrl,
    this.senderName,
  });
  final String sentBy;
  final String messageText;
  final Timestamp messageTime;
  final Widget message;
  bool? isSeen;
  final String imageUrl;
  String? senderName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChatBubble(
      clipper: sentBy == context.read<HomeCubit>().id ?
      ChatBubbleClipper4(
        type: SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ar ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.he ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.fa ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ur ?
        BubbleType.sendBubble : BubbleType.receiverBubble,
      ) :
      ChatBubbleClipper4(
        type: SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ar ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.he ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.fa ||
            SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ur ?
        BubbleType.receiverBubble : BubbleType.sendBubble,
      ),
      elevation: 2,
      alignment: sentBy == context.read<HomeCubit>().id &&
          SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ar ||
          SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.he ||
          SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.fa ||
          SharedPrefsManager.getStringData(key: AppStrings.language) == AppStrings.ur ?
      Alignment.centerRight :
      Alignment.centerLeft,
      backGroundColor: messageText != AppStrings.messageDeleted ? sentBy == context.read<HomeCubit>().id ?
      ColorManager.primaryColor :
      ColorManager.messageTextFieldBGColor :
      ColorManager.grey,
      shadowColor: Colors.grey.shade200,
      child: CustomStack(
        clipBehavior: Clip.none,
        children: [
          CustomContainer(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
            ),
            child: CustomColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                message,
                CustomSizedBox(height: size.height / 100,),
                CustomRow(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MessageTimeWidget(messageTime: messageTime, color: ColorManager.black.withOpacity(0.5),),
                    CustomSizedBox(width: size.height / 100,),
                    CustomBuilder(
                      builder: (context){
                        if(isSeen != null){
                          if(sentBy == context.read<HomeCubit>().id){
                            return IsMessageSeenWidget(isSeen: isSeen!);
                          }
                        }
                        return CustomSizedBox();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomBuilder(
            builder: (context){
              if(senderName != null){
                return CustomPositioned(
                  top: - size.height / 25,
                  child: CustomRow(
                    children: [
                      CustomCircleShapeWidget(
                          width: size.width / 22,
                          height: size.width / 22,
                          image: CustomBuilder(
                            builder: (context){
                              if(imageUrl.isNotEmpty){
                                return ClipOval(
                                  child: CustomCachedNetworkImageWidget(
                                    width: size.width / 10,
                                    height: size.width / 10,
                                    imageUrl: imageUrl,
                                    icon: Icons.person,
                                  ),
                                );
                              }
                              return CustomIcon(icon: Icons.person, color: ColorManager.grey, size: 10,);
                            },
                          )
                      ),
                      GroupMemberNameWidget(name: senderName!,),
                    ],
                  ),
                );
              }
              return CustomSizedBox();
            },
          )
        ],
      ),
    );
  }
}
