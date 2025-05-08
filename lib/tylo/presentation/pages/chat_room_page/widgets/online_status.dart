import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_center.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';

class OnlineStatusWidget extends StatefulWidget {
  const OnlineStatusWidget({super.key});

  @override
  State<OnlineStatusWidget> createState() => _OnlineStatusWidgetState();
}

class _OnlineStatusWidgetState extends State<OnlineStatusWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCenter(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          return Transform.scale(
            scale: _animation.value,
            child: CustomContainer(
              width: size.width / 50,
              height: size.width / 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}

