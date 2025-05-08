import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text_field.dart';
import '../../../../core/resources/color_manager.dart';

class ProfileNameTextFieldWidget extends StatelessWidget {
  const ProfileNameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          width: size.width,
          decoration: BoxDecoration(
              color: ColorManager.backgroundColor,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: ColorManager.white.withOpacity(0.3))
          ),
          child: CustomTextField(
            controller: context.read<FireStoreCubit>().profileNameController,
            height: size.height / 15,
            width: size.width,
            label: '',
            textInputType: TextInputType.text,
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}
