import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text_field.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';

class ContactPhoneNumberTextFieldWidget extends StatelessWidget {
  const ContactPhoneNumberTextFieldWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      width: size.width,
      decoration: BoxDecoration(
          color: ColorManager.backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: ColorManager.white.withOpacity(0.3))
      ),
      child: CustomTextField(
        controller:  context.read<ContactsCubit>().phoneNumberController,
        height: size.height / 15,
        width: size.width,
        label: translate(context, AppStrings.phone),
        textInputType: TextInputType.number,
        border: InputBorder.none,
      ),
    );
  }
}
