import 'package:flutter/material.dart';
import 'package:tylo/tylo/domain/entities/app_contact.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class BlockedContactTitleWidget extends StatelessWidget {
  const BlockedContactTitleWidget({super.key, required this.contact});
  final AppContact contact;

  @override
  Widget build(BuildContext context) {
    return CustomColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          data: contact.name,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white,
        ),
        ),
        CustomText(
          data: contact.phone,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white,
        ),
        ),
      ],
    );
  }
}
