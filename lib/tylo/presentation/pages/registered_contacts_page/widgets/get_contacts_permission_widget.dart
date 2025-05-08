import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';

import '../../../../core/components/custom_widgets/custom_center.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/custom_widgets/custom_text_button.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';

class GetContactsPermissionWidget extends StatelessWidget {
  const GetContactsPermissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCenter(
      child: CustomTextButton(
        onPressed: (){
          context.read<ContactsCubit>().getPermissionStatus(
            id: context.read<HomeCubit>().id,
          );
        },
        child: CustomContainer(
          alignment: Alignment.center,
          width: size.width / 1,
          height: size.width / 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: ColorManager.grey.withOpacity(0.5),
              )
          ),
          child:  CustomText(
            data: translate(context, AppStrings.allowPermission),
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ),
      ),
    );
  }
}
