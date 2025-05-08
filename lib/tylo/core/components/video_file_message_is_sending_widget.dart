import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'animated_dots.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';
import '../helper_functions/capitalize_all_words.dart';
import '../helper_functions/detect_language.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class VideoFileMessageIsSendingWidget extends StatelessWidget {
  const VideoFileMessageIsSendingWidget({super.key, required this.sentBy});
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
                final isLatinWord = detectWordLanguage(sentBy);
                return CustomText(
                  data: '${isLatinWord ? capitalizeAllWords(sentBy) : size} ${AppStrings.isSendingAVideo}',
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
