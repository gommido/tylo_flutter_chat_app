import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_text.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/chat_room_wallpaper_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'chat_room_bottom_widget.dart';
import 'chat_room_messages_list_widget.dart';

class ChatRoomBodyWidget extends StatelessWidget {
  const ChatRoomBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      children: [
        const ChatRoomWallpaperWidget(
          child: ChatRoomMessagesListWidget(),
        ),
        BlocConsumerWidget<FireStoreCubit, FireStoreState>(
          listener: (context, state){},
          builder: (context, state){
            if(context.read<FireStoreCubit>().streamAppUser != null){
              if(context.read<FireStoreCubit>().currentAppUser!.blockList.contains(context.read<FireStoreCubit>().streamAppUser!.id,)){
                return CustomContainer(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height / 15,
                  decoration: const BoxDecoration(
                    color: ColorManager.black,
                  ),
                  child: CustomText(
                    data: translate(context, AppStrings.youBlockedContact),
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                );
              }else if(context.read<FireStoreCubit>().streamAppUser!.blockList.contains(context.read<HomeCubit>().id)){
                return CustomContainer(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height / 15,
                  decoration: const BoxDecoration(
                    color: ColorManager.black,
                  ),
                  child: CustomText(
                    data: translate(context, AppStrings.sorryContactBlockedYou),
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                );
              }
            }
            return const ChatRoomBottomWidget();
          },
        )
      ],
    );
  }
}
