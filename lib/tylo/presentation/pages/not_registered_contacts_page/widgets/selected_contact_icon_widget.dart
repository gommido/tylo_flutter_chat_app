import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';

class SelectedContactIconWidget extends StatelessWidget {
  const SelectedContactIconWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<ContactsCubit, ContactsState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomBuilder(
            builder: (context){
              if(context.read<ContactsCubit>().selectedContact != null &&
                  context.read<ContactsCubit>().selectedContact! == index){
                return CustomCircleAvatar(
                  radius: 10,
                  backgroundColor: ColorManager.primaryColor,
                  child: CustomIcon(
                    icon: Icons.done,
                    size: size.width / 20,
                  ),
                );
              }
              return CustomSizedBox();
            },
          );
        },
    );
  }
}
