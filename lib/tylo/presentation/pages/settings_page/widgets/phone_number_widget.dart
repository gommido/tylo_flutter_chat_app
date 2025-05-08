import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      padding: const EdgeInsets.all(8.0),
      child: CustomRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomRow(
            children: [
              CustomIcon(icon: Icons.phone_android),
              CustomText(
                data: translate(context, AppStrings.phoneNumber),
                style: Theme.of(context).textTheme.bodySmall!,),
            ],
          ),
          CustomText(
            data: context.read<FireStoreCubit>().currentAppUser!.phone,
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ],
      ),
    );
  }
}
