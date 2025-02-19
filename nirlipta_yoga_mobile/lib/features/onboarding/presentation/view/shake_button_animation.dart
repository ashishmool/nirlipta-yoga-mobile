import 'package:flutter/material.dart';

class ShakeButtonAnimation extends StatefulWidget {
  final Widget child;

  const ShakeButtonAnimation({super.key, required this.child});

  @override
  _ShakeButtonAnimationState createState() => _ShakeButtonAnimationState();
}

class _ShakeButtonAnimationState extends State<ShakeButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // Loop the shake effect

    _shakeAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0), // Shake effect
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
