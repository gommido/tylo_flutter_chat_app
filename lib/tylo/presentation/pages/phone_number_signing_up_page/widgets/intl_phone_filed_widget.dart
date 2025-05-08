import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';

class IntlPhoneFieldWidget extends StatelessWidget {
  const IntlPhoneFieldWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AuthCubit, AuthState>(
      listener: (context, state){},
      builder: (context, state){
        final String initialCountryCode =  SharedPrefsManager.getMapData(key: AppStrings.country)[AppStrings.name];
        return IntlPhoneField(
          controller: context.read<AuthCubit>().phoneController,
          focusNode: context.read<AuthCubit>().focusNode,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManager.white,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.zeros,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.white.withOpacity(0.5),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
          ),
          pickerDialogStyle: PickerDialogStyle(
              countryNameStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.white,
              ),
              backgroundColor: ColorManager.primaryColor
          ),
          initialCountryCode: initialCountryCode,
          onChanged: (phone) {
            if(context.read<AuthCubit>().phoneController.text.length == 10){
              context.read<AuthCubit>().unFocus();
            }
            context.read<AuthCubit>().setPhoneNumber(phone.countryCode + phone.number);
          },
        );
      },
    );
  }
}
