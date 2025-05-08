import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_internet_checker.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'custom_bottom_sheet_user_filed_data_widget.dart';

class BottomSheetBioWidget extends StatefulWidget {
  const BottomSheetBioWidget({super.key});

  @override
  State<BottomSheetBioWidget> createState() => _BottomSheetBioWidgetState();
}

class _BottomSheetBioWidgetState extends State<BottomSheetBioWidget> {
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetUserFieldWidget(
      filedName: translate(context, AppStrings.editBio),
      firstDescription: translate(context, AppStrings.iCanSay),
      finalDescription: translate(context, AppStrings.expressYourself),
      textField: TextFormField(
        controller: _bioController,
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

            context.read<FireStoreCubit>().updateAppUserData(
              id: context.read<HomeCubit>().id,
              field: FireBaseConstants.bio,
              value: _bioController.text.isNotEmpty ? _bioController.text : null,
            );
            navigateAndPop(context);
          },
        );

      },
    );
  }
}
