import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class ScrollDownIconWidget extends StatelessWidget {
  const ScrollDownIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        if(context.read<ChatCubit>().isUserAtBottom != null && !context.read<ChatCubit>().isUserAtBottom!){
          return CustomPositioned(
            bottom: size.height / 10,
            child: CustomGestureDetector(
              onTap: (){
                context.read<ChatCubit>().scrollToBottom();
              },
              child: CustomStack(
                clipBehavior: Clip.none,
                children: [
                  CustomCircleAvatar(
                    radius: size.height / 40,
                    backgroundColor: ColorManager.primaryColor,
                    child: CustomIcon(
                      icon: Icons.arrow_downward_rounded,
                    ),
                  ),
                  CustomBuilder(
                    builder: (context){
                      if(context.read<ChatCubit>().unSeenMessagesCount != 0){
                        return CustomPositioned(
                          left: -5,
                          top: -5,
                          child: CustomCircleAvatar(
                            radius: size.height / 80,
                            backgroundColor: ColorManager.green,
                            child: CustomText(
                              data:context.read<ChatCubit>().unSeenMessagesCount.toString(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: FontManager.s12,
                              ),
                            ),
                          ),
                        );
                      }
                      return CustomSizedBox();
                    },
                  ),

                ],
              ),
            ),
          );
        }
       return CustomSizedBox();
      },
    );
  }
}
