import 'package:flutter/material.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class GroupsHomePageLastMessageTextWidget extends StatelessWidget {
  const GroupsHomePageLastMessageTextWidget({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
        builder: (context) {
          return CustomExpanded(
            child: CustomRow(
              children: [
                CustomExpanded(
                  child: CustomText(
                    data: group.lastMessage,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.white.withOpacity(0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
