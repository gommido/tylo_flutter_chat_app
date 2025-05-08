import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../../../core/components/custom_pick_image_bottom_sheet_widget.dart';
import '../../../../core/components/custom_speed_dial.dart';
import '../../../../core/components/custom_widgets/custom_bottom_sheet.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_speed_dial_child.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';

class BottomSpeedDialWidget extends StatelessWidget {
  const BottomSpeedDialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCircleAvatar(
      radius: 18,
      backgroundColor: ColorManager.primaryColor.withOpacity(0.5),
      child: CustomSpeedDial(
        icon: Icons.attach_file,
        isBottom: true,
        children: [
          customSpeedDialChild(
            context: context,
            icon: Icons.keyboard_voice,
            label: CustomText(
              data: translate(context, AppStrings.voiceNote),
              style: Theme.of(context).textTheme.bodySmall!,),
            onTap: (){
              context.read<ChatCubit>().setVoiceIconVisibility(isVisible: true);
            },
          ),
          customSpeedDialChild(
            context: context,
            icon: Icons.audio_file,
            label: CustomText(
              data: translate(context, AppStrings.audio),
              style: Theme.of(context).textTheme.bodySmall!,),
            onTap: (){
              context.read<FilePickerCubit>().pickFile(source: ImageSource.gallery, type: AppStrings.audio,);
            },
          ),
          customSpeedDialChild(
            context: context,
            icon: Icons.camera_alt,
            label: CustomText(
              data: translate(context, AppStrings.video),
              style: Theme.of(context).textTheme.bodySmall!,),
            onTap: (){
              CustomBottomSheet.showBottomSheet(
                context: context,
                child: const CustomPickImageBottomSheetWidget(
                  sourceName: AppStrings.videoSource,
                  type: AppStrings.video,
                ),
              );
            },
          ),
          customSpeedDialChild(
            context: context,
            icon: Icons.image,
            label: CustomText(
              data: translate(context, AppStrings.image),
              style: Theme.of(context).textTheme.bodySmall!,),
            onTap: (){
              CustomBottomSheet.showBottomSheet(
                context: context,
                child: const CustomPickImageBottomSheetWidget(
                  sourceName: AppStrings.imageSource,
                  type: AppStrings.image,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
