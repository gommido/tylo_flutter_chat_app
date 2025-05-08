import 'package:flutter/material.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_pick_image_bottom_sheet_widget.dart';
import '../../../../core/components/custom_widgets/custom_bottom_sheet.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/loading_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/firestorage_controller/firestorage_cubit.dart';

class EditProfilePickImageWidget extends StatelessWidget {
  const EditProfilePickImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCircleAvatar(
      radius: size.width / 15,
      backgroundColor: ColorManager.black.withOpacity(0.7),
      child: BlocConsumerWidget<FireStorageCubit, FireStorageState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomBuilder(
            builder: (context){
              if(state is UploadFileToFireStorageLoadingState){
                return const LoadingWidget(color: ColorManager.white);
              }
              return CustomGestureDetector(
                onTap: (){
                  CustomBottomSheet.showBottomSheet(
                    context: context,
                    child: const CustomPickImageBottomSheetWidget(
                      sourceName: AppStrings.imageSource,
                      type: AppStrings.image,
                    ),
                  );
                },
                child: CustomIcon(
                  icon: Icons.camera_alt,
                  size: size. width / 15,
                  color: ColorManager.white,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
