import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/controllers/chat_controller/chat_cubit.dart';
import '../resources/color_manager.dart';
import 'bloc_consumer_widget.dart';
import 'custom_widgets/custom_container.dart';

class SelectedMessageBackgroundWidget extends StatelessWidget {
  const SelectedMessageBackgroundWidget({super.key, required this.id, required this.child});
  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomContainer(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: context.read<ChatCubit>().isLongPressed != null
                && context.read<ChatCubit>().selectedItems.contains(id) ?
            ColorManager.grey.withOpacity(0.5) : Colors.transparent,
          ),
          child: child,
        );
      },
    );
  }
}
