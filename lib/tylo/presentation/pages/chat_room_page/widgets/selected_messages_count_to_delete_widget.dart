import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';

class SelectedMessagesCountToDeleteWidget extends StatelessWidget {
  const SelectedMessagesCountToDeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomText(
          data: '${context.watch<ChatCubit>().selectedItems.length} ${context.watch<ChatCubit>().selectedItems.length == 1
              ? translate(context, AppStrings.message) : translate(context, AppStrings.messages)}',
          style: Theme.of(context).textTheme.bodyMedium!,
        );
      },
    );
  }
}
