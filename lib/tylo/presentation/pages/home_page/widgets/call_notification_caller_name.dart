import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../controllers/call_controller/call_cubit.dart';

class CallNotificationCallerName extends StatelessWidget {
  const CallNotificationCallerName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<CallCubit, CallState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomBuilder(
              builder: (context) {
                final isLatinWord = detectWordLanguage(context.read<CallCubit>().room!.callerName);
                return CustomText(
                  data: isLatinWord ?
                  capitalizeAllWords(context.read<CallCubit>().room!.callerName) :
                  context.read<CallCubit>().room!.callerName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.white,
                      fontSize: FontManager.s18
                  ),
                );
              }
          );
        },
    );
  }
}
