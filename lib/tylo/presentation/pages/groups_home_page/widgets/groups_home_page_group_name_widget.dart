import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';

class GroupsHomePageGroupNameWidget extends StatelessWidget {
  const GroupsHomePageGroupNameWidget({super.key, required this.groupName});
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
      builder: (context){
        final isLatinWord = detectWordLanguage(groupName);
        return CustomText(
          data: isLatinWord ? capitalizeAllWords(groupName) : groupName,
          style: Theme.of(context).textTheme.bodyMedium!,
        );
      },
    );
  }
}
