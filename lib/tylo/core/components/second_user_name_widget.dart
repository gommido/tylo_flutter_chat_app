import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_text.dart';
import 'package:tylo/tylo/core/helper_functions/capitalize_all_words.dart';
import 'package:tylo/tylo/core/helper_functions/detect_language.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';

import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';

class SecondUserNameWidget extends StatelessWidget {
  const SecondUserNameWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
         if(context.read<FireStoreCubit>().streamAppUser != null){
           final user = context.read<FireStoreCubit>().streamAppUser!;
           final names = context.read<LocalStorageCubit>().storedRegisteredContacts
               .where((contact) => contact.id ==  user.id).toList();
           if(names.isNotEmpty){
             final isLatin = detectWordLanguage(names.first.name.split(' ').first);
             return CustomText(
               data: isLatin ? capitalizeAllWords(names.first.name.split(' ').first) : names.first.name.split(' ').first,
               style: Theme.of(context).textTheme.bodyMedium!,
             );
           }
           final isLatin = detectWordLanguage(user.name.split(' ').first);
           return CustomText(
             data: isLatin ? capitalizeAllWords(user.name.split(' ').first) : user.name.split(' ').first,
             style: Theme.of(context).textTheme.bodyMedium!,
           );
         }
         return CustomSizedBox();
        },
    );

  }
}
