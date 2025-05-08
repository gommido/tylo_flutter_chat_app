import 'package:flutter/material.dart';

class ThreeDotsAnimation extends StatefulWidget {
  const ThreeDotsAnimation({super.key});

  @override
  State<ThreeDotsAnimation> createState() => _ThreeDotsAnimationState();
}

class _ThreeDotsAnimationState extends State<ThreeDotsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDot(0),
              _buildDot(1),
              _buildDot(2),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDot(int index) {
    // Determine opacity based on animation value and dot index
    double opacity = _calculateOpacityForDot(index, _animation.value);
    return Opacity(
      opacity: opacity,
      child: Container(
        height: 5,
        width: 5,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  double _calculateOpacityForDot(int index, double animationValue) {
    // Each dot's animation is divided into 6 segments (2 segments per dot for appearing and disappearing)
    const segmentLength = 1 / 6; // Total animation is divided into 6 segments
    double start = segmentLength * (index * 2);
    double visibleEnd = start + segmentLength;
    double fadeStart = visibleEnd;
    double end = fadeStart + segmentLength;

    if (animationValue >= start && animationValue < visibleEnd) {
      // Dot is appearing - fade in
      return ((animationValue - start) / segmentLength).clamp(0.0, 1.0);
    } else if (animationValue >= fadeStart && animationValue < end) {
      // Dot is disappearing - fade out
      return (1.0 - (animationValue - fadeStart) / segmentLength).clamp(0.0, 1.0);
    } else {
      // Dot is invisible
      return 0.0;
    }
  }

}
