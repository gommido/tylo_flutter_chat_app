import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_icon.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_row.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupCreatedAtWidget extends StatelessWidget {
  const GroupCreatedAtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIcon(icon: Icons.watch_later, ),
        CustomSizedBox(width: size.width / 50,),
        CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: translate(context, AppStrings.createdAt),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            CustomSizedBox(height: size.height / 100,),
            CustomText(
              data: formatChatTimesInDays(context.read<GroupCubit>().group!.createdAt),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ],
    );
  }
}
