import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../resources/color_manager.dart';
import 'custom_widgets/custom_container.dart';

class MessageSideEndLineWidget extends StatelessWidget {
  const MessageSideEndLineWidget({super.key, required this.sentBy});
  final String sentBy;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: sentBy == context.read<HomeCubit>().id?
      size.width / 3 : size.width / 9,
      height: size.width / 200,
      decoration: BoxDecoration(
        color: sentBy == context.read<HomeCubit>().id ?
        ColorManager.transparent : ColorManager.primaryColor.withOpacity(0.5),
      ),
    );
  }
}
