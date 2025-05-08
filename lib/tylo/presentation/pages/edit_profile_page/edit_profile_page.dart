import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_scaffold.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/presentation/pages/edit_profile_page/widgets/edit_profile_page_app_bar_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/edit_profile_page/widgets/edit_profile_user_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/settings_page/widgets/phone_number_widget.dart';
import 'package:tylo/tylo/presentation/pages/edit_profile_page/widgets/profile_name_field_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_center.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../settings_page/widgets/bio_field_widget.dart';
import 'widgets/edit_profile_pick_image_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
        context: context,
        title: const EditProfilePageAppBarTitleWidget(),
        onPressed: (){
          navigateAndPop(context);
        },
      ),
      body: SingleChildScrollView(
        child: CustomCenter(
          child: CustomColumn(
            children: [
              CustomSizedBox(height: size.height / 25,),
              CustomStack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: const [
                  EditProfileUserImageWidget(),
                  EditProfilePickImageWidget(),
                ],
              ),
              CustomSizedBox(height: size.height / 50,),
              const ProfileNameFieldWidget(),
              CustomSizedBox(height: size.height / 25,),
              const BioFieldWidget(),
              CustomSizedBox(height: size.height / 25,),
              const PhoneNumberWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
