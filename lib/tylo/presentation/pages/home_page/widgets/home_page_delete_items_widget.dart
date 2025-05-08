import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_expanded.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';

import '../../../../core/components/arrow_back_icon.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'selected_items_to_delete_widget.dart';

class HomePageDeleteItemsWidget extends StatelessWidget {
  const HomePageDeleteItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomContainer(
          width: size.width,
          child: CustomRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomGestureDetector(
                onTap: (){
                  context.read<HomeCubit>().pressDeleteLongPress();
                  context.read<ChatCubit>().clearSelectedItems();
                },
                child: const ArrowBackIcon(),
              ),
              CustomSizedBox(width: size.width / 25,),
              const CustomExpanded(
                  child: SelectedItemsToDeleteWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
