import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';

class FileMessageBackgroundWidget extends StatelessWidget {
  const FileMessageBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return IgnorePointer(
          child: BlocConsumerWidget<FilePickerCubit, FilePickerState>(
            listener: (context, state) {},
            builder: (context, state) {
              return CustomContainer(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: (context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.image ||
                      context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.video ||
                      context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio) &&
                      context.read<ChatCubit>().isSendImageIconTapped != null ||
                      context.read<ChatCubit>().isVideoPlayerScreenFitted != null?
                  Colors.black.withOpacity(0.9) : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
