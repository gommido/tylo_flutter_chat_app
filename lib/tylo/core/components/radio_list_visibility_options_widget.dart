import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_column.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/navigator_pop.dart';
import 'package:tylo/tylo/core/resources/constants/app_user_visibility_options.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';

import '../../presentation/controllers/home_controller/home_cubit.dart';
import 'bloc_consumer_widget.dart';
import 'custom_widgets/custom_text.dart';

class RadioListVisibilityOptionsWidget extends StatelessWidget {
  const RadioListVisibilityOptionsWidget({super.key, required this.field, required this.value});
  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return CustomColumn(
      children: options.map((option){
        return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
          listener: (context, state){},
          builder: (context, state){
            return RadioListTile(
              title: CustomText(
                data: option,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              value: option,
              groupValue: value,
              onChanged: (onChanged){
                context.read<FireStoreCubit>().updateAppUserData(
                  id: context.read<HomeCubit>().id,
                  field: field,
                  value: option,
                );
                navigateAndPop(context);
              },
            );
          },
        );
      }).toList(),
    );
  }
}
