import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';

class AnimatedGlowingContainer extends StatefulWidget {
  AnimatedGlowingContainer({super.key, required this.width, required this.height, this.shape});
  final double width;
  final double height;
  BoxShape? shape;


  @override
  State<AnimatedGlowingContainer> createState() => _AnimatedGlowingContainerState();
}

class _AnimatedGlowingContainerState extends State<AnimatedGlowingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return CustomContainer(
          alignment: Alignment.center,
          width: size.width / 1.5,
          height: size.height / 5,
          decoration: BoxDecoration(
            shape: widget.shape == null ? BoxShape.rectangle : BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(_glowAnimation.value),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

/*
class AnimatedGlowingContainer extends StatefulWidget {

  const AnimatedGlowingContainer({
    Key? key,

  }) : super(key: key);

  @override
  _AnimatedGlowingContainerState createState() => _AnimatedGlowingContainerState();
}

class _AnimatedGlowingContainerState extends State<AnimatedGlowingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          alignment: Alignment.center,
          width: size.width / 1.5,
          height: size.height / 5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(_glowAnimation.value),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}


 */