import 'package:flutter/material.dart';
import 'package:tylo/tylo/presentation/pages/photo_visibility_page/widgets/photo_visibility_radio_list_widget.dart';
import 'package:tylo/tylo/presentation/pages/photo_visibility_page/widgets/who_can_see_my_profile_photo.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/photo_visibility_title_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';

class PhotoVisibilityPage extends StatelessWidget {
  const PhotoVisibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const PhotoVisibilityTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: CustomPadding(
        padding: const EdgeInsets.all(10.0),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(height: size.height / 50,),
            const WhoCanSeeMyProfilePhoto(),
            CustomSizedBox(height: size.height / 50,),
            const PhotoVisibilityRadioListWidget(),
          ],
        ),
      ),
    );
  }
}
