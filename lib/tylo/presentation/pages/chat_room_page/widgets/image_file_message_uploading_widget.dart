import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/animated_dots.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/local_storage_controller/local_storage_cubit.dart';

class ImageFileMessageUploadingWidget extends StatelessWidget {
  const ImageFileMessageUploadingWidget({super.key, required this.sentBy});
  final String sentBy;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      height: size.height / 2.5,
      width: size.width / 2,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: ColorManager.black,
        border: Border.all(
          color: ColorManager.primaryColor.withOpacity(0.3),
        ),
      ),
      child: CustomColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomBuilder(
              builder: (context) {
                final name = context.read<LocalStorageCubit>().getStoredContactName(id: sentBy);
                final isLatinWord = detectWordLanguage(name);
                return CustomText(
                  data: '${isLatinWord ? capitalizeAllWords(name) : name} ${translate(context, AppStrings.isSendingAVideo)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: FontManager.s08,
                  ),
                );
              }
          ),
          CustomSizedBox(height: size.height / 100,),
          const AnimatedDots(),
        ],
      ),
    );
  }
}
