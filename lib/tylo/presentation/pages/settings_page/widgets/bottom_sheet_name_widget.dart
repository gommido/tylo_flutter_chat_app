import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_snack_bar.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';

import '../../../../core/components/custom_widgets/custom_internet_checker.dart';

import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'custom_bottom_sheet_user_filed_data_widget.dart';

class BottomSheetNameWidget extends StatefulWidget {
  const BottomSheetNameWidget({super.key});

  @override
  State<BottomSheetNameWidget> createState() => _BottomSheetNameWidgetState();
}

class _BottomSheetNameWidgetState extends State<BottomSheetNameWidget> {
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetUserFieldWidget(
      filedName: translate(context, AppStrings.name),
      firstDescription: translate(context, AppStrings.wantToBeCalled),
      finalDescription: translate(context, AppStrings.yourNameIs),
      textField: TextFormField(
        controller: _nameController,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodySmall!,
        autofillHints: const [AutofillHints.email],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.grey,
          ),
        ),
        maxLength: 35,
      ),
      onPressed: (){
        CustomInternetChecker.checkInternetAvailability(
          context: context,
          onInternetAvailable: (){
            final name = _nameController.text.trim();
            if(name.isNotEmpty && name.length >= 5){
              context.read<FireStoreCubit>().updateAppUserData(
                id: context.read<HomeCubit>().id,
                field: FireBaseConstants.name,
                value: name,
              );
              navigateAndPop(context);

            }else{
              CustomToast.show(title: AppStrings.nameMustNotBeLess);
            }
          },
        );

      },
    );
  }
}
