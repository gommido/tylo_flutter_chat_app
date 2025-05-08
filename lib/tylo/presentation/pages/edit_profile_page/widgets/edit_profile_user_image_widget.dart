import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/current_user_profile_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/firestorage_controller/firestorage_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class EditProfileUserImageWidget extends StatelessWidget {
  const EditProfileUserImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){
        if(state is PickFileSuccessState && context.read<FilePickerCubit>().pickedFile != null){
          context.read<FireStorageCubit>().uploadFileToFireStorage(
            folder: AppStrings.images,
            file: context.read<FilePickerCubit>().pickedFile!.$1!,
          ).then((value){
            context.read<FireStoreCubit>().updateAppUserData(
              id: context.read<HomeCubit>().id,
              field: FireBaseConstants.photo,
              value: value,
            );
          });
        }
      },
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomCircleShapeWidget(
            width: size.width / 2,
            height: size.width / 2,
            image: CurrentUserProfileImageWidget(
              width: size.width / 2,
              height: size.width / 2,
            ),
        );

      },
    );
  }
}
