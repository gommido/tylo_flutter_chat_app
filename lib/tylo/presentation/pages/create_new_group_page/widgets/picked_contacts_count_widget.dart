import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';

class PickedContactsCountWidget extends StatelessWidget {
  const PickedContactsCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomPadding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: ColorManager.primaryColor.withOpacity(0.5),
            child:  CustomText(
              data: context.watch<GroupCubit>().selectedContacts.length.toString(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: FontManager.s14,
              ),
            ),
          ),
        );
      },
    );
  }
}
