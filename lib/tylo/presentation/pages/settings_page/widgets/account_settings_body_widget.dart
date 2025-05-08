import 'package:flutter/material.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/profile_title_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_divider.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/resources/color_manager.dart';
import 'block_list_title_widget.dart';

class AccountSettingsBodyWidget extends StatelessWidget {
  const AccountSettingsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: ColorManager.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CustomColumn(
        children: [
          const ProfileTitleWidget(),
          CustomPadding(
            padding: const EdgeInsets.all(12.0),
            child: CustomDivider(color: ColorManager.grey.withOpacity(0.1),),
          ),
          const BlockListTitleWidget(),
        ],
      ),
    );
  }
}
