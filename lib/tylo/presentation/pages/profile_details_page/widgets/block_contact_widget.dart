import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';

import '../../../../core/components/custom_widgets/custom_internet_checker.dart';
import '../../../../core/components/navigation_button_widget.dart';
import '../../../../core/helper_functions/block_contact.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class BlockContactWidget extends StatelessWidget {
  const BlockContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state) {},
      builder: (context, state) {
        return NavigationButtonWidget(
          backColor: context.read<FireStoreCubit>().streamAppUser != null &&
              !context.read<FireStoreCubit>().streamAppUser!.blockList.contains(context.read<ChatCubit>().otherChatUserId) ?
              ColorManager.transparent : ColorManager.white,
          borderColor: ColorManager.white.withOpacity(0.2),
          onNavigationState: () {
            CustomInternetChecker.checkInternetAvailability(
              context: context,
              onInternetAvailable: () {
                blockContact(context: context);
              },
            );
          },
          buttonTitle: AppStrings.block,
        );
      },
    );
  }
}
