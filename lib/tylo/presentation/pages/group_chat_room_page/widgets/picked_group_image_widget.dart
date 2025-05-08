import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_file_image_widget.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';

class PickedGroupImageWidget extends StatelessWidget {
  const PickedGroupImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return GestureDetector(
          onTap: (){
            context.read<FilePickerCubit>().pickFile(source: ImageSource.gallery, type: AppStrings.image,);
          },
          child: CustomBuilder(
            builder: (context){
              if(context.read<FilePickerCubit>().pickedFile != null){
                return CustomFileImageWidget(
                  height: size.width / 4,
                  width: size.width / 4,
                  imagePath: context.read<FilePickerCubit>().pickedFile!.$1!.path,
                );
              }
              return CustomFileImageWidget(
                height: size.width / 4,
                width: size.width / 4,
                imagePath: '',
              );
            },
          ),
        );
      },
    );
  }
}
