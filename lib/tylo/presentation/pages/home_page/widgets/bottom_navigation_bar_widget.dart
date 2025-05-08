import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (index) => AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    ));
    _animations = _controllers.map((controller) =>
        Tween(begin: 1.0, end: 0.8).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        )
    ).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    for (var controller in _controllers) {
      controller.reverse();
    }
    _controllers[index].forward().then((value) {
      _controllers[index].reverse();
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        final tabs = context.read<HomeCubit>().getTabs(
          context: context,
          count: context.read<HomeCubit>().id.isNotEmpty ?
          context.watch<ChatCubit>().getUnSeenNewChatsCount(id: context.read<HomeCubit>().id) :
          null,
        );
        return BottomNavigationBar(
          elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          currentIndex: context.read<HomeCubit>().currentIndex,
          selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
          items: List.generate(tabs.length, (index) {
            return BottomNavigationBarItem(
              icon: ScaleTransition(
                scale: _animations[index],
                child: tabs[index].icon,
              ),
              label: translate(context, tabs[index].label!),
            );
          }),
          onTap: (int index){
            _onItemTapped(index);
            context.read<HomeCubit>().changePage(index);
            if(context.read<HomeCubit>().isLongPressed != null){
              context.read<HomeCubit>().pressDeleteLongPress();
              context.read<ChatCubit>().clearSelectedItems();
            }
          },
        );
      },
    );
  }
}
