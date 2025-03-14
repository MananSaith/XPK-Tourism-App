import 'package:flutter/material.dart';

class CustomAnimated extends StatefulWidget {
  final Widget child; // Required
  final Curve? curve; // Nullable
  final Alignment? alignment; // Nullable
  final Duration? duration; // Nullable
  final Tween<Offset> tween; // Nullable
  final double? beginX; // Nullable
  final double? beginY; // Nullable

  const CustomAnimated({
    Key? key,
    required this.child, // Keep this required
    this.curve, // Nullable
    this.alignment, // Nullable
    this.duration, // Nullable
    required this.tween, // Nullable
    this.beginX, // Nullable
    this.beginY, // Nullable
  }) : super(key: key);

  @override
  _CustomAnimatedState createState() => _CustomAnimatedState();
}

class _CustomAnimatedState extends State<CustomAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
          widget.duration ?? const Duration(seconds: 1), // Default duration
    );

    _animation = (widget.tween).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? Curves.linear, // Default curve
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment ?? Alignment.center, // Default alignment
      child: SlideTransition(
        position: _animation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
