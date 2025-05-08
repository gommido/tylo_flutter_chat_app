import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupMembersCountWidget extends StatelessWidget {
  const GroupMembersCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomText(
          data: context.read<GroupCubit>().group != null ?
          '${context.read<GroupCubit>().group!.membersIds.length.toString()} ${translate(context, 'members')}' : '',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.grey, fontSize: FontManager.s12,
          ),
        );
      },
    );
  }
}
