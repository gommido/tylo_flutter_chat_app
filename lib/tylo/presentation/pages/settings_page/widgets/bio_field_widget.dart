import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../edit_profile_page/widgets/edit_profile_info_bottom_sheet_widget.dart';

class BioFieldWidget extends StatelessWidget {
  const BioFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        context.read<FireStoreCubit>().setEditProfileBottomSheetName(AppStrings.bio);
        showModalBottomSheet(
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            context: context,
            isScrollControlled: true,
            builder: (builder){
              return const EditProfileInfoBottomSheetWidget();
            }
        );
      },
      child: CustomPadding(
        padding: const EdgeInsets.all(8.0),
        child: CustomRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRow(
              children: [
                CustomIcon(icon: Icons.edit_note_sharp),
                CustomText(
                  data: translate(context, AppStrings.bio),
                  style: Theme.of(context).textTheme.bodySmall!,),
              ],
            ),
            CustomRow(
              children: [
                BlocConsumerWidget<FireStoreCubit, FireStoreState>(
                  listener: (context, state){},
                  builder: (context, state){
                    if(context.read<FireStoreCubit>().currentAppUser!.bio.isEmpty){
                      return CustomText(
                        data: translate(context, AppStrings.typeSomething),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.grey.withOpacity(0.5)
                        ),
                      );

                    }
                    return CustomBuilder(
                      builder: (context) {
                        final bio = context.watch<FireStoreCubit>().currentAppUser!.bio;
                        final isLatinWord = detectWordLanguage(bio);
                        return CustomText(
                          data: bio.isNotEmpty? isLatinWord ? capitalizeAllWords(bio) : bio : '',
                          style: Theme.of(context).textTheme.bodySmall!,
                        );
                      }
                    );
                  },
                ),
                CustomIcon(icon: Icons.arrow_forward_ios),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
