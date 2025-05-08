import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_bottom_sheet.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_pick_image_bottom_sheet_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';

class PickingProfileImageWidget extends StatelessWidget {
  const PickingProfileImageWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
        onTap: () {
          CustomBottomSheet.showBottomSheet(
            context: context,
            child: const CustomPickImageBottomSheetWidget(
              sourceName: AppStrings.imageSource,
              type: AppStrings.image,
            ),
          );
        },
        child: BlocConsumerWidget<FilePickerCubit, FilePickerState>(
          listener: (context, state){},
          builder: (context, state){
            return CustomPadding(
              padding: const EdgeInsets.all(8.0),
              child: CustomColumn(
                children: [
                  CustomBuilder(
                    builder: (context){
                      if(context.read<FilePickerCubit>().pickedFile == null){
                        return CustomContainer(
                          width: size.width / 1.5,
                          height: size.width / 1.5,
                          decoration: BoxDecoration(
                            color: ColorManager.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ColorManager.white.withOpacity(0.1),
                            ),
                          ),
                          child: CustomIcon(
                            icon: Icons.camera_alt,
                            size: size.width / 10,
                            color:  ColorManager.primaryColor.withOpacity(0.5),
                          ),
                        );
                      }
                      return CustomContainer(
                        alignment: AlignmentDirectional.topStart,
                        padding: const EdgeInsets.all(8.0),
                        width: size.width / 1.5,
                        height: size.width / 1.5,
                        decoration: BoxDecoration(
                            color: ColorManager.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ColorManager.white.withOpacity(0.1),
                            ),
                            image: DecorationImage(
                              image: FileImage(context.watch<FilePickerCubit>().pickedFile!.$1!,),
                              fit: BoxFit.cover,
                            ),
                        ),
                      );
                    },
                  ),
                  CustomSizedBox(height: size.height / 100,),
                ],
              )

            );
          },
        ),
    );
  }
}

