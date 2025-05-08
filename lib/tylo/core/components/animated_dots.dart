import 'dart:async';
import 'package:flutter/material.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_row.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  int _dotIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _dotIndex = (_dotIndex + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _animatedOpacityWidget(opacity: _dotIndex >= 1 ? 1.0 : 0.0,),
        _animatedOpacityWidget(opacity: _dotIndex >= 2 ? 1.0 : 0.0,),
        _animatedOpacityWidget(opacity: _dotIndex >= 3 ? 1.0 : 0.0,),
      ],
    );
  }
}

Widget _animatedOpacityWidget({required double opacity}){
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity: opacity,
    child: CustomContainer(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
    ),
  );
}