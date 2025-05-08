import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class DeletedChatIconWidget extends StatelessWidget {
  const DeletedChatIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        if(context.read<HomeCubit>().isLongPressed != null){
          return CustomContainer(
            width: size.width / 8,
            height: size.width / 8,
            decoration: BoxDecoration(
              color: ColorManager.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: CustomIcon(
              icon: Icons.done_sharp,
              color: ColorManager.green,
            ),
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
