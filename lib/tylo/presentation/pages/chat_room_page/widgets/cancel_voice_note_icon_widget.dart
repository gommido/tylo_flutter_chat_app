import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_icon_button.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class CancelVoiceNoteIconWidget extends StatelessWidget {
  const CancelVoiceNoteIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomCircleAvatar(
          radius: 18,
          backgroundColor: context.read<ChatCubit>().isVoiceIconVisible != null ? ColorManager.red : ColorManager.primaryColor.withOpacity(0.5),
          child: CustomIconButton(
            onPressed: (){
              context.read<ChatCubit>().setVoiceIconVisibility();
            },
            icon: CustomIcon(
              icon: Icons.close,
              size: size.height / 45,
              color: ColorManager.white,
            ),
          ),
        );
      },
    );
  }
}
