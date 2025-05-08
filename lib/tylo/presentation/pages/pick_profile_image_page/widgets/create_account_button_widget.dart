import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/presentation/controllers/firestorage_controller/firestorage_cubit.dart';
import 'package:tylo/tylo/core/components/navigation_button_widget.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  const CreateAccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
        onNavigationState: (){
          context.read<FireStoreCubit>().createUserWithPhoneNumber(
            phoneNumber: context.read<AuthCubit>().phoneNumber,
            onUploadProfileImage: context.read<FilePickerCubit>().pickedFile != null ?
            context.read<FireStorageCubit>().uploadFileToFireStorage(
                folder: FireBaseConstants.images,
                file: context.read<FilePickerCubit>().pickedFile!.$1!,
            ) : null,
          );
        },
        buttonTitle: AppStrings.createAccount,
    );
  }
}
