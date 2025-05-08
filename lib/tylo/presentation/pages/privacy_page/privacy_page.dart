import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/last_seen_and_online_status_widget.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/privacy_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/profile_photo_visibility.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/who_can_see_personal_info_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const PrivacyAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: CustomPadding(
        padding: const EdgeInsets.all(10.0),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WhoCanSeePersonalInfoWidget(),
            CustomSizedBox(height: size.height / 25,),
            const LastSeenAndOnlineStatusWidget(),
            CustomSizedBox(height: size.height / 25,),
            const ProfilePhotoVisibility(),
          ],
        ),
      ),
    );
  }
}
