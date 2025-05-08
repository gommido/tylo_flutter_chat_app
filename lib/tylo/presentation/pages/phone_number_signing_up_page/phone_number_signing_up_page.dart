import 'package:flutter/material.dart';
import 'package:tylo/tylo/presentation/pages/phone_number_signing_up_page/widgets/first_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/phone_number_signing_up_page/widgets/intl_phone_filed_widget.dart';
import 'package:tylo/tylo/presentation/pages/phone_number_signing_up_page/widgets/navigation_to_otp_button_widget.dart';
import 'package:tylo/tylo/presentation/pages/phone_number_signing_up_page/widgets/second_title_widget.dart';
import '../../../core/components/custom_widgets/custom_app_bar.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_spacer.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';

class PhoneNumberSigningUpPage extends StatelessWidget {
  const PhoneNumberSigningUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: customAppBar(
          context: context,
          onPressed: (){
            navigateAndPop(context);
          },
      ),
      body: CustomContainer(
        padding: const EdgeInsets.all(10.0),
        child: CustomColumn(
          children: [
            CustomSizedBox(height: size.height / 25,),
            const FirstTitleWidget(),
            CustomSizedBox(height: size.height / 10,),
            const SecondTitleWidget(),
             CustomSizedBox(height: size.height / 50,),
            const IntlPhoneFieldWidget(),
            const CustomSpacer(),
            const NavigationToOtpPageButtonWidget(),
            CustomSizedBox(height: size.height / 20,),
          ],
        ),
      ),
    );
  }
}

