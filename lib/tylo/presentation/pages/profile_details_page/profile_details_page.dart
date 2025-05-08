import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_divider.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/components/second_user_name_widget.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/widgets/block_contact_widget.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/widgets/interaction_with_contact_widget.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/widgets/contact_bio_widget.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/widgets/contact_online_status_widget.dart';
import 'package:tylo/tylo/presentation/pages/profile_details_page/widgets/contact_phone_number_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_padding.dart';
import '../../../core/components/stream_user_profile_image_widget.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const SecondUserNameWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          padding: const EdgeInsets.all(10.0),
          child: CustomColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamUserProfileImageWidget(
                width: size.width / 2,
                height: size.width / 2,
              ),
              CustomSizedBox(height: size.height / 50,),
              const SecondUserNameWidget(),
              CustomSizedBox(height: size.height / 100,),
              const ContactPhoneNumberWidget(),
              CustomSizedBox(height: size.height / 100,),
              const ContactOnlineStatusWidget(),
              CustomSizedBox(height: size.height / 100,),
              const ContactBioWidget(),
              CustomSizedBox(height: size.height / 100,),
              CustomDivider(color: ColorManager.grey.withOpacity(0.2),),
              CustomSizedBox(height: size.height / 25,),
              const InteractionWithContactWidget(),
              CustomSizedBox(height: size.height / 25,),
              const BlockContactWidget(),

            ],
          ),
        ),
      )

    );
  }
}
