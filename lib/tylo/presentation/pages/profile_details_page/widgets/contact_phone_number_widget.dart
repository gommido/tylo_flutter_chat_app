import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class ContactPhoneNumberWidget extends StatelessWidget {
  const ContactPhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final number = context.read<FireStoreCubit>().streamAppUser!.phone;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomText(
        data: '${AppStrings.plus}${number.substring(2)}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorManager.grey,
        ),
      ),
    );
  }
}
