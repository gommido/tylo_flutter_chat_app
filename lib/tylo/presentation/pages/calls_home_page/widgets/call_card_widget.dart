import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/call.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'caller_details_widget.dart';
import 'caller_image_widget.dart';

class CallCardWidget extends StatelessWidget {
  const CallCardWidget({super.key, required this.call});
  final Call call;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomGestureDetector(
      onTap: (){
        if(context.read<ChatCubit>().selectedItems.isEmpty){
          context.read<ChatCubit>().setOtherChatUserId(call.secondUserId);
          pushNamed(route: AppRoutes.chatRoomPage, context: context,);
        }else{
          if(context.read<ChatCubit>().selectedItems.length == 1 && context.read<ChatCubit>().selectedItems.contains(call.id)){
            context.read<ChatCubit>().clearSelectedItems();
            context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: null);
          }else{
            if(!context.read<ChatCubit>().selectedItems.contains(call.id)){
              context.read<ChatCubit>().selectItems(call.id);
            }else{
              context.read<ChatCubit>().removeFromSelectedItems(call.id);
            }
          }
        }

      },
      onLongPress: (){
        if(context.read<ChatCubit>().selectedItems.isEmpty){
          context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: true,);
          context.read<ChatCubit>().selectItems(call.id);
        }else{
          if(context.read<ChatCubit>().selectedItems.length == 1  && context.read<ChatCubit>().selectedItems.contains(call.id)){
            context.read<ChatCubit>().clearSelectedItems();
            context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: null);
          }else if(!context.read<ChatCubit>().selectedItems.contains(call.id)){
            context.read<ChatCubit>().selectItems(call.id);
          }else{
            context.read<ChatCubit>().removeFromSelectedItems(call.id);
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
                    && context.read<ChatCubit>().selectedItems.contains(call.id) ?
                ColorManager.grey.withOpacity(0.5) : Colors.transparent,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.02),
                )
            ),
            child: CustomRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CallerImageWidget(call: call,),
                CustomSizedBox(width: size.width / 50,),
                CallerDetailsWidget(call: call,),
              ],
            ),
          );
        },
      ),
    );
  }
}
