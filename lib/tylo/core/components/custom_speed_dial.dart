import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_icon.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import '../resources/color_manager.dart';

class CustomSpeedDial extends StatelessWidget {
  const CustomSpeedDial({super.key, required this.children, required this.icon, required this.isBottom,});
  final List<SpeedDialChild> children;
  final IconData icon;
  final bool isBottom;
  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return SpeedDial(
          direction: isBottom ? SpeedDialDirection.up : SpeedDialDirection.down,
          overlayOpacity: 0.0,
          children: children,
          child: CustomIcon(
            icon: icon,
            color: ColorManager.white,
          ),
        );
      },
    );
  }
}


