import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';

import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class PickedContactIconWidget extends StatelessWidget {
  const PickedContactIconWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
        listener: (context, state){},
        builder: (context, state){
          if(context.read<GroupCubit>().isContactPicked[index]){
            return CustomIcon(
              icon: Icons.check_circle,
              color: ColorManager.primaryColor,
            );
          }
          return CustomSizedBox();
        });
  }
}
