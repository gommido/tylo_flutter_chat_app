import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/components/navigation_button_widget.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class CreateGroupButtonWidget extends StatelessWidget {
  const CreateGroupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return NavigationButtonWidget(
          onNavigationState: (){
            if(context.read<GroupCubit>().groupNameController.text.trim().isNotEmpty){
              context.read<GroupCubit>().createGroup(
                ownerId: context.read<HomeCubit>().id,
                file: context.read<FilePickerCubit>().pickedFile?.$1,
              );
            }else{
              CustomToast.show(title: translate(context, AppStrings.groupMustNotEmpty));
            }
          },
          buttonTitle: AppStrings.createGroup,
        );
      },
    );
  }
}
