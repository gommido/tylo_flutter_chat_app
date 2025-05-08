import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class GroupNameWidget extends StatelessWidget {
  const GroupNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        final name = context.read<GroupCubit>().group != null ? context.read<GroupCubit>().group!.name : '';
        final isLatinWord = detectWordLanguage(name);
        return CustomText(
          data: isLatinWord ?
          capitalizeAllWords(name) :
          name,
          style: Theme.of(context).textTheme.bodyMedium!,
        );
      },
    );
  }
}
