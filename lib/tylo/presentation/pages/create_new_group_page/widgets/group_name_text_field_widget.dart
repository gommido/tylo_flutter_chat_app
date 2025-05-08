import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_text_field.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupNameTextFieldWidget extends StatelessWidget {
  const GroupNameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomTextField(
          onChanged: (_){},
          label: translate(context, AppStrings.groupName),
          controller: context.read<GroupCubit>().groupNameController,
          textInputType: TextInputType.text,
          height: size.height / 10,
          width: size.width - 50,
          maxLength: 25,
        );
      },
    );
  }
}
