import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../../presentation/controllers/group_controller/group_cubit.dart';
import '../resources/color_manager.dart';
import 'animated_dots.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_stack.dart';

class ImageFileMessageSenderFileLoadingWidget extends StatelessWidget {
  const ImageFileMessageSenderFileLoadingWidget({super.key, required this.isGroupChatPage, required this.imageFile});
  final File imageFile;
  final bool isGroupChatPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      height: size.height / 2.5,
      width: size.width / 2,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: ColorManager.black,
        border: Border.all(
          color: ColorManager.primaryColor.withOpacity(0.3),
        ),
        image: DecorationImage(
          image: FileImage(imageFile),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: CustomBuilder(
        builder: (context){
          if(isGroupChatPage){
            if(context.read<GroupCubit>().imageUploadingProgress != null){
              return CustomContainer(
                  alignment: Alignment.center,
                  width: size.width / 25,
                  height: size.width / 25,
                  child: CustomStack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: size.width / 20,
                        backgroundColor: ColorManager.white,
                        percent: context.watch<GroupCubit>().imageUploadingProgress != null ?
                        (context.watch<GroupCubit>().imageUploadingProgress! / 10.toDouble()) : 0.0,
                        progressColor: ColorManager.green,
                        lineWidth: size.width / 200,
                      ),
                      const AnimatedDots(),
                    ],
                  )
              );
            }
          }
          if(context.read<ChatCubit>().imageUploadingProgress != null){
            return CustomContainer(
                alignment: Alignment.center,
                width: size.width / 25,
                height: size.width / 25,
                child: CustomStack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: size.width / 20,
                      backgroundColor: ColorManager.white,
                      percent: context.watch<ChatCubit>().imageUploadingProgress != null ?
                      (context.watch<ChatCubit>().imageUploadingProgress! / 10.toDouble()) : 0.0,
                      progressColor: ColorManager.green,
                      lineWidth: size.width / 200,
                    ),
                    const AnimatedDots(),
                  ],
                )
            );
          }
          return CustomSizedBox();
        },
      ),
    );
  }
}
