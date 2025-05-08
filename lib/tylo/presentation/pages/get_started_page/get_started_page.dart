import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_padding.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/presentation/pages/get_started_page/widgets/app_logo_widget.dart';
import 'package:tylo/tylo/presentation/pages/get_started_page/widgets/contine_with_phone_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/get_started_page/widgets/create_account_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/get_started_page/widgets/privacy_policy_and_terms_widget.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomScaffold(
      body: CustomPadding(
        padding: const EdgeInsets.all(10.0),
        child: CustomStack(
          alignment: Alignment.center,
          children: [
            CustomColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomSpacer(),
                const AppLogoWidget(),
                const CreateAccountTitleWidget(),
                CustomSizedBox(height: size.height / 25,),
                const ContinueWithPhoneButtonWidget(),
                /*
                  CustomSizedBox(height: size.height / 25,),
                  const OrSignUpWithWidget(),
                  CustomSizedBox(height: size.height / 25,),
                  const SocialSignUpWidget(),
                   */
                const CustomSpacer(),
                const PrivacyPolicyAndTermsWidget(),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
