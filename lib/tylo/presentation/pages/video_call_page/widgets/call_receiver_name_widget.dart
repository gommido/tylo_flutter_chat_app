import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class CallReceiverNameWidget extends StatelessWidget {
  const CallReceiverNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomBuilder(
              builder: (context) {
                final isLatinWord = detectWordLanguage(context.read<FireStoreCubit>().streamAppUser!.name.split(' ').first);
                return CustomText(
                  data: isLatinWord ?
                  capitalizeAllWords(context.read<FireStoreCubit>().streamAppUser!.name) :
                  context.read<FireStoreCubit>().streamAppUser!.name,
                  style: Theme.of(context).textTheme.bodyLarge!,
                );
              }
          );
        },
    );
  }
}
