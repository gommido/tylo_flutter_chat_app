import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupNameWidget extends StatelessWidget {
  const GroupNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: context.read<GroupCubit>().group!.name,
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
