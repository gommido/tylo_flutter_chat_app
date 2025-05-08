import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/firestorage_controller/firestorage_cubit.dart';

class GroupImageWidget extends StatelessWidget {
  const GroupImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){
        if(state is PickFileSuccessState && context.read<FilePickerCubit>().pickedFile != null){
          context.read<FireStorageCubit>().uploadFileToFireStorage(
            folder: AppStrings.images,
            file: context.read<FilePickerCubit>().pickedFile!.$1!,
          ).then((value){
            context.read<GroupCubit>().updateGroupData(
              field: AppStrings.image,
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
            image: BlocConsumerWidget<GroupCubit, GroupState>(
              listener: (context, state){},
              builder: (context, state){
                return CustomBuilder(
                  builder: (context){
                    if(context.read<GroupCubit>().group!.image.isNotEmpty){
                      return ClipOval(
                        child: CustomCachedNetworkImageWidget(
                          width: size.width / 2,
                          height: size.width / 2,
                          imageUrl: context.watch<GroupCubit>().group!.image,
                          icon: Icons.person,
                        ),
                      );
                    }
                    return CustomIcon(icon: Icons.group, color: ColorManager.grey,);
                  },
                );
              },
            ),
        );

      },
    );

  }
}
