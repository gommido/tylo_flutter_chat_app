import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/font_manager.dart';

class GroupMemberNameWidget extends StatelessWidget {
  const GroupMemberNameWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 11,),
      child: CustomBuilder(
        builder: (context) {
          final isLatinWord = detectWordLanguage(name);
          return CustomText(
            data: isLatinWord ? capitalizeAllWords(name) : name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: FontManager.s08,
            ),
          );
        }
      ),
    );
  }
}
