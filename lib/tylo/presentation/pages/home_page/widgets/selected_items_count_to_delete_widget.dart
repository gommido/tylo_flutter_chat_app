import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class SelectedItemsCountToDeleteWidget extends StatelessWidget {
  const SelectedItemsCountToDeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state){},
          builder: (context, state){
            switch(context.watch<HomeCubit>().currentIndex){
              case 0:
                return CustomText(
                  data: '${context.watch<ChatCubit>().selectedItems.length} ${translate(context, AppStrings.chatsSmall)}',
                  style: Theme.of(context).textTheme.bodyMedium!,
                );
              case 1:
                return CustomText(
                  data: '${context.watch<ChatCubit>().selectedItems.length} ${translate(context, AppStrings.callsSmall)}',
                  style: Theme.of(context).textTheme.bodyMedium!,
                );
              case 2:
                return CustomText(
                  data: '${context.watch<ChatCubit>().selectedItems.length} ${translate(context, AppStrings.groupsSmall)}',
                  style: Theme.of(context).textTheme.bodyMedium!,
                );
            }
            return CustomText(
              data: '${context.watch<ChatCubit>().selectedItems.length} ${translate(context, AppStrings.chatsSmall)}',
              style: Theme.of(context).textTheme.bodyMedium!,
            );
          },
        );
      },
    );
  }
}
