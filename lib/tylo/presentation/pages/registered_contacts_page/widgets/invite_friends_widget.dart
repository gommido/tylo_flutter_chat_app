import 'package:flutter/material.dart';
import 'package:tylo/tylo/presentation/pages/registered_contacts_page/widgets/share_icon_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import 'invite_friends_text_widget.dart';
import 'invite_text_widget.dart';

class InviteFriendsWidget extends StatelessWidget {
  const InviteFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      padding: const EdgeInsets.all(15.0),
      width: size.width,
      height: size.height / 5,
      decoration: BoxDecoration(
          color: ColorManager.messageTextFieldBGColor,
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: CustomColumn(
        children: [
          CustomRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShareIconWidget(),
              CustomSizedBox(width: size.width / 25,),
              const InviteFriendsTextWidget(),
            ],
          ),
          CustomSizedBox(height: size.height / 50,),
          CustomRow(
            children: const [
              Spacer(),
              InviteTextWidget(),
            ],
          )

        ],
      ),
    );
  }
}
