import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class GroupLastMessageOwnerNameWidget extends StatelessWidget {
  const GroupLastMessageOwnerNameWidget({super.key, required this.id, required this.lastMessageSenderName});
  final String id;
  final String lastMessageSenderName;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
      builder: (context) {
        final name = lastMessageSenderName.split(' ').first;
        final isLatinWord = detectWordLanguage(name);
        return CustomText(
          data: lastMessageSenderName.isNotEmpty ?
          id == context.read<HomeCubit>().id ?
          '${translate(context, AppStrings.no)}: ': '${isLatinWord ? capitalizeAllWords(name) : name}: ' :
          translate(context, AppStrings.noMessages),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManager.white.withOpacity(0.5),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
    );
  }
}
